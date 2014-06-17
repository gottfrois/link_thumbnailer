require 'spec_helper'

describe LinkThumbnailer::Configuration do

  let(:instance) { described_class.new }

  it { expect(instance.redirect_limit).to         eq(3) }
  it { expect(instance.user_agent).to             eq('link_thumbnailer') }
  it { expect(instance.verify_ssl).to             eq(true) }
  it { expect(instance.http_timeout).to           eq(5) }
  it { expect(instance.blacklist_urls).to_not     be_empty }
  it { expect(instance.attributes).to             eq([:title, :images, :description, :videos]) }
  it { expect(instance.graders).to_not            be_empty }
  it { expect(instance.description_min_length).to eq(25) }
  it { expect(instance.positive_regex).to_not     be_nil }
  it { expect(instance.negative_regex).to_not     be_nil }
  it { expect(instance.image_limit).to            eq(5) }
  it { expect(instance.image_stats).to            eq(true) }

  describe '.config' do

    it { expect(LinkThumbnailer.config).to be_a(described_class) }

  end

  describe '.configure' do

    before do
      LinkThumbnailer.stub(:config).and_return(instance)
    end

    context 'when block given' do

      it 'yields' do
        expect(LinkThumbnailer).to receive(:configure).and_yield(instance)
        LinkThumbnailer.configure {|config|}
      end

    end

    context 'when no block given' do

      it 'does nothing' do
        expect(LinkThumbnailer.configure).to be_nil
      end

    end

  end

end

