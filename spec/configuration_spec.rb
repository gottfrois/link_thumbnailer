# frozen_string_literal: true

require 'spec_helper'

describe LinkThumbnailer::Configuration do

  let(:instance) { described_class.new }

  it { expect(instance.redirect_limit).to         eq(3) }
  it { expect(instance.user_agent).to             eq('link_thumbnailer') }
  it { expect(instance.verify_ssl).to             eq(true) }
  it { expect(instance.http_open_timeout).to      eq(5) }
  it { expect(instance.http_read_timeout).to      eq(5) }
  it { expect(instance.blacklist_urls).to_not     be_empty }
  it { expect(instance.attributes).to             eq([:title, :images, :description, :videos, :favicon, :body]) }
  it { expect(instance.graders).to_not            be_empty }
  it { expect(instance.description_min_length).to eq(50) }
  it { expect(instance.positive_regex).to_not     be_nil }
  it { expect(instance.negative_regex).to_not     be_nil }
  it { expect(instance.image_limit).to            eq(5) }
  it { expect(instance.image_stats).to            eq(true) }
  it { expect(instance.max_concurrency).to        eq(20) }
  it { expect(instance.encoding).to               eq('utf-8') }

  describe "#http_timeout" do
    it { expect(instance.method(:http_timeout)).to eq(instance.method(:http_open_timeout)) }
    it { expect(instance.method(:http_timeout=)).to eq(instance.method(:http_open_timeout=)) }
  end

  describe '.config' do

    it { expect(LinkThumbnailer.config).to be_a(described_class) }

  end

  describe '.configure' do

    before do
      allow(LinkThumbnailer).to receive(:config).and_return(instance)
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
