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

      it { expect { action }.to_not change { instance.images.size }.by(1) }

    end

  end

end
