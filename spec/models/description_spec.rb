# frozen_string_literal: true

require 'spec_helper'

describe LinkThumbnailer::Models::Description do

  let(:text)      { 'bar' }
  let(:grader)    { double(call: 0) }
  let(:node)      { double(text: 'bar') }
  let(:instance)  { described_class.new(node, text) }

  before do
    expect(LinkThumbnailer::Grader).to receive(:new).at_least(1).times.and_return(grader)
  end

  describe '#to_s' do

    let(:action) { instance.to_s }

    it { expect(action).to eq(text) }

  end

  describe '#<=>' do

    let(:another_instance)  { described_class.new(node, text) }
    let(:probability)       { 0.5 }
    let(:action)            { instance <=> another_instance }

    before do
      another_instance.probability = probability
    end

    context 'when instance probability is lower' do

      before do
        instance.probability = probability - 0.5
      end

      it { expect(action).to eq(-1) }

    end

    context 'when instance probability is equal' do

      before do
        instance.probability = probability
      end

      it { expect(action).to eq(0) }

    end

    context 'when instance probability is greater' do

      before do
        instance.probability = probability + 0.5
      end

      it { expect(action).to eq(1) }

    end

  end

end
