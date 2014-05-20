require 'spec_helper'

describe LinkThumbnailer::Graders::Length do

  let(:config)      { double('config') }
  let(:description) { double('description') }
  let(:instance)    { described_class.new(description) }

  before do
    instance.stub(:config).and_return(config)
  end

  describe '#call' do

    let(:action) { instance.call(0) }

    context 'when text is too short' do

      before do
        instance.stub(:too_short?).and_return(true)
      end

      it { expect(action).to eq(-Float::INFINITY) }

    end

    context 'when text is not too short' do

      before do
        instance.stub(:too_short?).and_return(false)
        instance.stub(:text).and_return(text)
      end

      context 'when text length is greater than 400' do

        let(:text) { 'f' * 400 }

        it { expect(action).to eq(3) }

      end

      context 'when text length is less than 300' do

        let(:text) { 'f' * 299 }

        it { expect(action).to eq(2) }

      end

    end

  end

  describe '#too_short?' do

    let(:action) { instance.send(:too_short?) }

    before do
      instance.stub_chain(:config, :description_min_length).and_return(10)
      instance.stub(:text).and_return(text)
    end

    context 'when true' do

      let(:text) { 'f' * 9 }

      it { expect(action).to be_true }

    end

    context 'when false' do

      let(:text) { 'f' * 10 }

      it { expect(action).to be_false }

    end

  end

end
