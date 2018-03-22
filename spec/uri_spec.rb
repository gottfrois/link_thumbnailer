# frozen_string_literal: true

require 'spec_helper'

describe LinkThumbnailer::URI do

  let(:uri)       { 'http://foo.com' }
  let(:instance)  { described_class.new(uri) }

  describe '#valid?' do

    let(:action) { instance.send(:valid?) }

    context 'when bad format' do

      before do
        allow(instance).to receive(:attribute).and_return("/invalid/path")
      end

      it { expect(action).to be_falsey }

    end

    context 'when valid format' do

      before do
        allow(instance).to receive(:attribute).and_return("http://foo.com")
      end

      it { expect(action).to be_truthy }

    end

  end

  describe '#to_s' do

    let(:action) { instance.to_s }

    it { expect(action).to eq(uri) }

  end

end
