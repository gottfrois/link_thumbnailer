require 'spec_helper'

describe LinkThumbnailer::ImageParsers::Size do

  describe '.perform' do

    let(:size)    { [10, 10] }
    let(:src)     { 'http://foo.com' }
    let(:image)   { double(src: src) }
    let(:action)  { described_class.perform(image) }

    context 'when no exception is raised' do

      before do
        expect(FastImage).to receive(:size).with(src, raise_on_failure: true).and_return(size)
      end

      it { expect(action).to eq(size) }

    end

    context 'when an exception is raised' do

      before do
        expect(FastImage).to receive(:size).with(src, raise_on_failure: true).and_raise(FastImage::FastImageException)
      end

      it { expect(action).to eq([0, 0]) }

    end

  end

end
