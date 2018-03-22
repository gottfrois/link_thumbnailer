# frozen_string_literal: true

require 'spec_helper'

describe LinkThumbnailer::Graders::HtmlAttribute do

  let(:description) { double('description') }
  let(:instance)    { described_class.new(description, :class) }

  describe '#call' do

    let(:action) { instance.call }

    context 'when current node does not match attribute' do

      before do
        allow(instance).to receive(:attribute?).and_return(false)
      end

      it { expect(action).to eq(1.0) }

    end

    context 'when current node has a negative attribute' do

      before do
        allow(instance).to receive(:attribute?).and_return(true)
        allow(instance).to receive(:negative?).and_return(true)
        allow(instance).to receive(:positive?).and_return(false)
      end

      it { expect(action).to eq(0.0) }

    end

    context 'when current node has a positive attribute' do

      before do
        allow(instance).to receive(:attribute?).and_return(true)
        allow(instance).to receive(:negative?).and_return(false)
        allow(instance).to receive(:positive?).and_return(true)
      end

      it { expect(action).to eq(1.0) }

    end

  end

end
