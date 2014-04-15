require 'spec_helper'

describe LinkThumbnailer::ImageComparators::Size do

  let(:image)     { double(size: [20, 20]) }
  let(:instance)  { described_class.new(image) }

  describe '#call' do

    let(:other)   { double(size: other_size) }
    let(:action)  { instance.call(other) }

    context 'when other has a better image' do

      let(:other_size) { [10, 10] }

      it { expect(action).to eq(-1) }

    end

    context 'when other has an identical image' do

      let(:other_size) { [20, 20] }

      it { expect(action).to eq(0) }

    end

    context 'when other has a weaker image' do

      let(:other_size) { [30, 30] }

      it { expect(action).to eq(1) }

    end

  end

end
