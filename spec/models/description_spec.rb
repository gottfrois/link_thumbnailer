require 'spec_helper'

describe LinkThumbnailer::Models::Description do

  let(:text)      { 'bar' }
  let(:grader)    { double(call: 0) }
  let(:node)      { double(text: 'bar') }
  let(:instance)  { described_class.new(node, text) }

  before do
    ::LinkThumbnailer::Grader.should_receive(:new).at_least(1).and_return(grader)
  end

  describe '#to_s' do

    let(:action) { instance.to_s }

    it { expect(action).to eq(text) }

  end

  describe '#<=>' do

    let(:another_instance)  { described_class.new(node, text) }
    let(:score)             { 5 }
    let(:action)            { instance <=> another_instance }

    before do
      another_instance.score = score
    end

    context 'when instance score is lower' do

      before do
        instance.score = score - 1
      end

      it { expect(action).to eq(-1) }

    end

    context 'when instance score is equal' do

      before do
        instance.score = score
      end

      it { expect(action).to eq(0) }

    end

    context 'when instance score is greater' do

      before do
        instance.score = score + 1
      end

      it { expect(action).to eq(1) }

    end

  end

end
