require 'spec_helper'

describe LinkThumbnailer::Scraper do

  let(:source)    { '' }
  let(:url)       { 'http://foo.com' }
  let(:document)  { double('document') }
  let(:website)   { double('website') }
  let(:instance)  { described_class.new(source, url) }

  before do
    instance.stub(:document).and_return(document)
    instance.stub(:website).and_return(website)
  end

  describe '#call' do

    let(:prefix_1)                { 'prefix_1' }
    let(:prefix_2)                { 'prefix_2' }
    let(:scraper_class)           { double('scraper_class') }
    let(:applicable_scraper)      { double(applicable?: true) }
    let(:not_applicable_scraper)  { double(applicable?: false) }
    let(:attributes)              { [:bar] }
    let(:scrapers)                { [prefix_1, prefix_2] }
    let(:action)                  { instance.call }

    before do
      instance.stub_chain(:config, :attributes).and_return(attributes)
      instance.stub(:scrapers).and_return(scrapers)
    end

    context 'when first scraper not applicable' do

      before do
        expect(website).to            receive(:bar).and_return('bar')
        expect(applicable_scraper).to receive(:call).with(website, 'bar')
        expect(scraper_class).to      receive(:new).with(document).and_return(applicable_scraper)
        expect(instance).to           receive(:scraper_class).with(prefix_1, :bar).and_return(scraper_class)
      end

      it { expect(action).to eq(website) }

    end

    context 'when first scraper applicable' do

      before do
        expect(website).to                    receive(:bar).and_return('bar')
        expect(not_applicable_scraper).to_not receive(:call).with(website, 'bar')
        expect(scraper_class).to              receive(:new).with(document).and_return(not_applicable_scraper)
        expect(instance).to                   receive(:scraper_class).with(prefix_1, :bar).and_return(scraper_class)
      end

      it { expect(action).to eq(website) }

    end

    context 'when all scrapers applicable and first one return a result' do

      let(:valid_scraper)     { double('scraper', applicable?: true) }
      let(:not_valid_scraper) { double('scraper', applicable?: true) }

      before do
        expect(website).to                receive(:bar).once.and_return('bar')
        expect(valid_scraper).to          receive(:call).once.with(website, 'bar')
        expect(not_valid_scraper).to_not  receive(:call).with(website, 'bar')
        expect(scraper_class).to          receive(:new).with(document).once.and_return(valid_scraper)
        expect(instance).to               receive(:scraper_class).with(prefix_1, :bar).and_return(scraper_class)
      end

      it { expect(action).to eq(website) }

    end

    context 'when all scrapers applicable but first one do not return any result' do

      let(:valid_scraper)     { double('scraper', applicable?: true) }
      let(:not_valid_scraper) { double('scraper', applicable?: true) }

      before do
        expect(website).to            receive(:bar).and_return('', 'bar')
        expect(valid_scraper).to      receive(:call).once.with(website, 'bar')
        expect(not_valid_scraper).to  receive(:call).once.with(website, 'bar')
        expect(scraper_class).to      receive(:new).with(document).and_return(not_valid_scraper, valid_scraper)
        expect(instance).to           receive(:scraper_class).with(prefix_1, :bar).and_return(scraper_class)
        expect(instance).to           receive(:scraper_class).with(prefix_2, :bar).and_return(scraper_class)
      end

      it { expect(action).to eq(website) }

    end

  end

end
