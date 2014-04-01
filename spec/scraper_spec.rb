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

    let(:scraper_class) { double('scraper_class') }
    let(:scraper)       { double('scraper') }
    let(:attributes)    { [:foo] }
    let(:action)        { instance.call }

    before do
      instance.stub_chain(:config, :attributes).and_return(attributes)

      expect(scraper).to receive(:call).with(website, 'foo')
      expect(scraper_class).to receive(:new).with(document).and_return(scraper)
      expect(instance).to receive(:scraper_class).with(:foo).and_return(scraper_class)
    end

    it { expect(action).to eq(website) }

  end

  describe '#scraper_class_name' do

    let(:class_name)  { 'Foo' }
    let(:action)      { instance.send(:scraper_class_name, class_name) }

    context 'when opengraph' do

      before do
        instance.stub(:opengraph?).and_return(true)
      end

      it { expect(action).to eq("::LinkThumbnailer::Scrapers::Opengraph::#{class_name}") }

    end

    context 'by default' do

      before do
        instance.stub(:opengraph?).and_return(false)
      end

      it { expect(action).to eq("::LinkThumbnailer::Scrapers::Default::#{class_name}") }

    end

  end

  describe '#opengraph?' do

    let(:node)    { double('node') }
    let(:meta)    { [node, node] }
    let(:action)  { instance.send(:opengraph?) }

    before do
      instance.stub(:meta).and_return(meta)
    end

    context 'when all node is an opengraph' do

      before do
        instance.stub(:opengraph_node?).and_return(true, true)
      end

      it { expect(action).to be_true }

    end

    context 'when any node is an opengraph' do

      before do
        instance.stub(:opengraph_node?).and_return(true, false)
      end

      it { expect(action).to be_true }

    end

    context 'when no node is an opengraph' do

      before do
        instance.stub(:opengraph_node?).and_return(false, false)
      end

      it { expect(action).to be_false }

    end

  end

end
