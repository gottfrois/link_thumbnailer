# frozen_string_literal: true

require 'spec_helper'

describe LinkThumbnailer::Graders::Base do

  let(:description) { double('description', text: 'foo', node: node) }
  let(:node)        { double('node', text: 'foo') }
  let(:instance)    { described_class.new(description) }

  it { expect(instance.send(:node)).to eq(description.node) }
  it { expect(instance.send(:text)).to eq(description.text) }

end
