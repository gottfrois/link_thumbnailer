# frozen_string_literal: true

require 'spec_helper'

describe LinkThumbnailer::Grader do

  let(:description) { double('description') }
  let(:instance)    { described_class.new(description) }

  describe '#call' do

    let(:probability)   { 0.5 }
    let(:weight) { 2 }
    let(:grader)  { double('grader', call: probability, weight: weight) }
    let(:lambda)  { ->(_) { grader } }
    let(:graders) { [lambda, lambda] }
    let(:action)  { instance.call }

    before do
      allow(instance).to receive(:graders).and_return(graders)
    end

    it { expect(action).to eq((0.5 * 0.5) ** weight) }

  end

end
