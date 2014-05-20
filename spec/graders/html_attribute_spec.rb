require 'spec_helper'

describe LinkThumbnailer::Graders::HtmlAttribute do

  let(:description) { double('description') }
  let(:instance)    { described_class.new(description, :class) }

  describe '#call' do

    let(:action) { instance.call(0) }

    context 'when current node does not match attribute' do

      before do
        instance.stub(:attribute?).and_return(false)
      end

      it { expect(action).to eq(0) }

    end

    context 'when current node has a negative attribute' do

      before do
        instance.stub(:attribute?).and_return(true)
        instance.stub(:negative?).and_return(true)
        instance.stub(:positive?).and_return(false)
      end

      it { expect(action).to eq(-25) }

    end

    context 'when current node has a positive attribute' do

      before do
        instance.stub(:attribute?).and_return(true)
        instance.stub(:negative?).and_return(false)
        instance.stub(:positive?).and_return(true)
      end

      it { expect(action).to eq(25) }

    end

  end

end
