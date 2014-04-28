require 'spec_helper'

describe LinkThumbnailer::Graders::LinkDensity do

  let(:config)      { double('config') }
  let(:description) { double('description') }
  let(:instance)    { described_class.new(config, description) }

  describe '#call' do

    let(:previous_score)  { 1 }
    let(:density)         { 10 }
    let(:action)          { instance.call(previous_score) }

    before do
      instance.stub(:density).and_return(density)
    end

    it { expect(action).to eq(-9) }

  end

end
