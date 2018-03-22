# frozen_string_literal: true

require 'spec_helper'

describe LinkThumbnailer::Graders::LinkDensity do

  let(:description) { double('description') }
  let(:instance)    { described_class.new(description) }

  describe '#call' do

    let(:action) { instance.call }

    before do
      allow(instance).to receive(:text).and_return(text)
      allow(instance).to receive(:links).and_return(links)
    end

    context 'when text length is 0' do

      let(:text) { '' }
      let(:links) { [] }

      it { expect(action).to eq(0.0) }

    end

    context 'when text length is > 0' do

      let(:text) { 'foo' }

      context 'and links is 0' do

        let(:links) { [] }

        it { expect(action).to eq(1.0) }

      end

      context 'and links is > 0' do

        let(:links) { [1] }

        it { expect(action).to be_within(0.001).of(0.666) }

      end

    end

  end

end
