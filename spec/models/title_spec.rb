require 'spec_helper'

describe LinkThumbnailer::Models::Title do

  let(:node)      { double(text: 'bar') }
  let(:instance)  { described_class.new(node, text) }

  context 'when text provided' do

    let(:text) { 'foo' }

    it { expect(instance.to_s).to eq(text) }

  end

  context 'when text not provided' do

    let(:text) { nil }

    it { expect(instance.to_s).to eq(node.text) }

  end

end
