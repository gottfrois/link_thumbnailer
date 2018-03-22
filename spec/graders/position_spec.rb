# frozen_string_literal: true

require 'spec_helper'

describe LinkThumbnailer::Graders::Position do

  let(:description) { double('description') }
  let(:instance)    { described_class.new(description) }

  describe '#call' do

    let(:action) { instance.call }

    context 'when position is 0' do

      before do
        allow(description).to receive(:position).and_return(0)
        allow(description).to receive(:candidates_number).and_return(1)
      end

      it { expect(action).to eq(1.0) }

    end

    context 'when position is 1 over 1 candidates' do

      before do
        allow(description).to receive(:position).and_return(1)
        allow(description).to receive(:candidates_number).and_return(1)
      end

      it { expect(action).to eq(0.0) }

    end

    context 'when position is 1 over more than 1 candidates' do

      before do
        allow(description).to receive(:position).and_return(1)
        allow(description).to receive(:candidates_number).and_return(2)
      end

      it { expect(action).to eq(0.5) }

    end

  end

end
