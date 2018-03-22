# frozen_string_literal: true

require 'spec_helper'

describe LinkThumbnailer::Graders::Length do

  let(:config)      { double('config') }
  let(:description) { double('description') }
  let(:instance)    { described_class.new(description) }

  before do
    allow(instance).to receive(:config).and_return(config)
  end

  describe '#call' do

    let(:action) { instance.call }

    context 'when text is too short' do

      before do
        allow(instance).to receive(:too_short?).and_return(true)
      end

      it { expect(action).to eq(0.0) }

    end

    context 'when text is not too short' do

      before do
        allow(instance).to receive(:too_short?).and_return(false)
        allow(instance).to receive(:text).and_return(text)
      end

      context 'when text length is 120' do

        let(:text) { 'f' * 120 }

        it { expect(action).to eq(1.0) }

      end

      context 'when text length is 100' do

        let(:text) { 'f' * 100 }

        it { expect(action).to be < 1.0 }

      end

      context 'when text length is 60' do

        let(:text) { 'f' * 60 }

        it { expect(action).to be < 1.0 }

      end

    end

  end

  describe '#too_short?' do

    let(:action) { instance.send(:too_short?) }
    let(:config) { double }

    before do
      allow(instance).to receive(:config).and_return(config)
      allow(config).to receive(:description_min_length).and_return(10)
      allow(instance).to receive(:text).and_return(text)
    end

    context 'when true' do

      let(:text) { 'f' * 9 }

      it { expect(action).to be_truthy }

    end

    context 'when false' do

      let(:text) { 'f' * 10 }

      it { expect(action).to be_falsey }

    end

  end

end
