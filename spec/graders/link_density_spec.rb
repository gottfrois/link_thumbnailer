require 'spec_helper'

describe LinkThumbnailer::Graders::LinkDensity do

  let(:description) { double('description') }
  let(:instance)    { described_class.new(description) }

  describe '#call' do

    let(:previous_score)  { 1 }
    let(:action)          { instance.call(previous_score) }

    context 'when density_ratio is 0' do

      before do
        instance.stub(:density_ratio).and_return(0)
      end

      it { expect(action).to eq(0) }

    end

    context 'when density is not 0' do

      before do
        instance.stub(:density_ratio).and_return(10)
      end

      it { expect(action).to eq(10) }

    end

  end

  describe '#density' do

    let(:links)   { ['foo'] }
    let(:action)  { instance.send(:density) }

    before do
      instance.stub(:links).and_return(links)
      instance.stub(:text).and_return(text)
    end

    context 'with text' do

      let(:text)    { 'abcd' }

      it { expect(action).to eq(0.25) }

    end

    context 'without text' do

      let(:text)    { '' }

      it { expect(action).to eq(0) }

    end

  end

end
