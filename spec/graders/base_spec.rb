require 'spec_helper'

describe LinkThumbnailer::Graders::Base do

  let(:config)      { double('config') }
  let(:description) { double('description', node: node) }
  let(:node)        { double('node', text: 'foo') }
  let(:instance)    { described_class.new(config, description) }

  it { expect(instance.send(:node)).to eq(description.node) }
  it { expect(instance.send(:text)).to eq(description.node.text) }

end
