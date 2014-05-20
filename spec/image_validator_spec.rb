require 'spec_helper'

describe LinkThumbnailer::ImageValidator do

  let(:src)       { 'http://foo.com' }
  let(:image)     { double(src: src) }
  let(:instance)  { described_class.new(image) }

  describe '#call' do

    let(:action) { instance.call }

    before do
      instance.stub(:blacklist_urls).and_return(blacklist_urls)
    end

    context 'when image url is blacklisted' do

      let(:blacklist_urls) { [src] }

      it { expect(action).to be_false }

    end

    context 'when image url is not blacklisted' do

      let(:blacklist_urls) { [] }

      it { expect(action).to be_true }

    end

  end

end
