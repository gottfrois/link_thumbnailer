require 'spec_helper'

describe LinkThumbnailer::Models::Website do

  let(:instance) { described_class.new }

  it { expect(instance.images).to be_empty }

  describe '#image=' do

    let(:image)   { double }
    let(:action)  { instance.image = image }

    before do
      image.stub(:valid?).and_return(true)
    end

    it { expect { action }.to change { instance.images.size }.by(1) }

  end

  describe '#images=' do

    let(:image)   { double }
    let(:action)  { instance.images = image }

    context 'when image is valid' do

      before do
        image.stub(:valid?).and_return(true)
      end

      it { expect { action }.to change { instance.images.size }.by(1) }

    end

    context 'when image is not valid' do

      before do
        image.stub(:valid?).and_return(false)
      end

      it { expect { action }.to_not change { instance.images.size } }

    end

  end

  describe '#scheme' do

    subject { ::LinkThumbnailer::Models::Website.new }

    before do
      subject.url = url
    end

    context 'when protocol is https' do
      let(:url) { "https://foo.com" }

      it 'returns https scheme' do
        expect(subject.scheme).to eq "https"
      end
    end

    context 'when protocol is http' do
      let(:url) { "http://bar.com" }

      it 'returns http scheme' do
        expect(subject.scheme).to eq "http"
      end
    end
  end
end
