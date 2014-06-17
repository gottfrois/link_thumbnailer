require 'spec_helper'

describe LinkThumbnailer::ImageParsers::Type do

  describe '.perform' do

    let(:type)    { 'png' }
    let(:src)     { 'http://foo.com' }
    let(:image)   { double(src: src) }
    let(:action)  { described_class.perform(image) }

    context 'when no exception is raised' do

      before do
        expect(FastImage).to receive(:type).with(src, raise_on_failure: true).and_return(type)
      end

      it { expect(action).to eq(type) }

    end

    context 'when an exception is raised' do

      before do
        expect(FastImage).to receive(:type).with(src, raise_on_failure: true).and_raise(FastImage::FastImageException)
      end

      it { expect(action).to be_nil }

    end

  end

end
