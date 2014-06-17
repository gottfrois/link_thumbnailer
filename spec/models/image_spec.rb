require 'spec_helper'

describe LinkThumbnailer::Models::Image do

  let(:src)       { 'http://foo.com' }
  let(:instance)  { described_class.new(src) }

  before do
    stub_request(:get, src).to_return(status: 200, body: '', headers: {})
  end

  describe '#to_s' do

    let(:action) { instance.to_s }

    it { expect(action).to eq(src) }

  end

  describe '#<=>' do

    let(:other)   { double(size: other_size) }
    let(:action)  { instance <=> other }

    before do
      instance.stub(:size).and_return([20, 20])
    end

    context 'when other has a smaller image' do

      let(:other_size) { [10, 10] }

      it { expect(action).to eq(-1) }

    end

    context 'when other as identical image size' do

      let(:other_size) { [20, 20] }

      it { expect(action).to eq(0) }

    end

    context 'when other as a bigger image' do

      let(:other_size) { [30, 30] }

      it { expect(action).to eq(1) }

    end

  end

  describe '#valid?' do

    let(:validator) { double }
    let(:action)    { instance.valid? }

    before do
      instance.stub(:validator).and_return(validator)
    end

    it 'calls validator public method' do
      expect(validator).to receive(:call)
      action
    end

  end

  describe '#as_json' do

    let(:action)  { instance.as_json }
    let(:size)    { [1, 1] }
    let(:type)    { 'foo' }
    let(:result)  {
      {
        src:  src,
        size: size,
        type: type
      }
    }

    before do
      instance.stub(:size).and_return(size)
      instance.stub(:type).and_return(type)
    end

    it { expect(action).to eq(result) }

  end

end
