require 'spec_helper'

describe LinkThumbnailer::Grader do

  let(:description) { double('description') }
  let(:instance)    { described_class.new(description) }

  describe '#call' do

    let(:probability)   { 0.5 }
    let(:grader)  { double('grader', call: probability) }
    let(:lambda)  { ->(_) { grader } }
    let(:graders) { [lambda, lambda] }
    let(:action)  { instance.call }

    before do
      instance.stub(:graders).and_return(graders)
    end

    it { expect(action).to eq(0.5 * 0.5) }

  end

end
