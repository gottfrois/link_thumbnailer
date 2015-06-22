require 'spec_helper'

describe LinkThumbnailer::Graders::PunctuationDensity do

  let(:description) { double('description') }
  let(:instance)    { described_class.new(description) }

  describe '#call' do

    let(:action) { instance.call }

    before do
      instance.stub(:text).and_return(text)
      instance.stub(:punctuations).and_return(punctuations)
    end

    context 'when text length is 0' do

      let(:text) { '' }
      let(:punctuations) { [] }

      it { expect(action).to eq(0.0) }

    end

    context 'when text length is > 0' do

      let(:text) { 'foo' }

      context 'and punctuations is 0' do

        let(:punctuations) { [] }

        it { expect(action).to eq(1.0) }

      end

      context 'and punctuations is > 0' do

        let(:punctuations) { [1] }

        it { expect(action).to be_within(0.001).of(0.666) }

      end

    end

  end

end
