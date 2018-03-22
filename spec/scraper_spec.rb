# frozen_string_literal: true

require 'spec_helper'

describe LinkThumbnailer::Scraper do

  let(:source)    { '' }
  let(:url)       { 'http://foo.com' }
  let(:document)  { double('document') }
  let(:website)   { double('website') }
  let(:instance)  { described_class.new(source, url) }

  before do
    allow(instance).to receive(:document).and_return(document)
    allow(instance).to receive(:website).and_return(website)
  end

  describe '#call' do

    let(:prefix_1)                { 'prefix_1' }
    let(:prefix_2)                { 'prefix_2' }
    let(:scraper_class)           { double('scraper_class') }
    let(:scraper)                 { double('scraper', call: true) }
    let(:attributes)              { [:bar] }
    let(:scrapers)                { [prefix_1, prefix_2] }
    let(:action)                  { instance.call }
    let(:config)                  { double(attributes: attributes, scrapers: scrapers) }

    before do
      allow(instance).to receive(:config).and_return(config)
    end

    context 'when first one return a result' do

      let(:valid_scraper)     { double('scraper') }
      let(:not_valid_scraper) { double('scraper') }

      before do
        expect(website).to                receive(:bar).once.and_return('bar')
        expect(valid_scraper).to          receive(:call).once.with('bar')
        expect(not_valid_scraper).to_not  receive(:call).with('bar')
        expect(scraper_class).to          receive(:new).with(document, website).once.and_return(valid_scraper)
        expect(instance).to               receive(:scraper_class).with(prefix_1, :bar).and_return(scraper_class)
      end

      it { expect(action).to eq(website) }

    end

    context 'when first one does not return any result' do

      let(:valid_scraper)     { double('scraper') }
      let(:not_valid_scraper) { double('scraper') }

      before do
        expect(website).to            receive(:bar).and_return('', 'bar')
        expect(valid_scraper).to      receive(:call).once.with('bar')
        expect(not_valid_scraper).to  receive(:call).once.with('bar')
        expect(scraper_class).to      receive(:new).with(document, website).and_return(not_valid_scraper, valid_scraper)
        expect(instance).to           receive(:scraper_class).with(prefix_1, :bar).and_return(scraper_class)
        expect(instance).to           receive(:scraper_class).with(prefix_2, :bar).and_return(scraper_class)
      end

      it { expect(action).to eq(website) }

    end

  end

end
