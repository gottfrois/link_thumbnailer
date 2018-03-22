# frozen_string_literal: true

require 'spec_helper'

describe LinkThumbnailer::Scrapers::Opengraph::Base do

  let(:node)      { double('node') }
  let(:document)  { double('document') }
  let(:instance)  { described_class.new(document) }

  describe '#applicable?' do

    let(:meta)    { [node, node] }
    let(:action)  { instance.applicable? }

    before do
      allow(instance).to receive(:meta).and_return(meta)
    end

    context 'when all node is an opengraph' do

      before do
        allow(instance).to receive(:opengraph_node?).and_return(true, true)
      end

      it { expect(action).to be_truthy }

    end

    context 'when any node is an opengraph' do

      before do
        allow(instance).to receive(:opengraph_node?).and_return(true, false)
      end

      it { expect(action).to be_truthy }

    end

    context 'when no node is an opengraph' do

      before do
        allow(instance).to receive(:opengraph_node?).and_return(false, false)
      end

      it { expect(action).to be_falsey }

    end

  end

  describe '#opengraph_node?' do

    let(:action) { instance.send(:opengraph_node?, node) }

    before do
      allow(node).to receive(:attribute).with('name').and_return(attribute_from_name)
    end

    context 'with attribute from name valid' do

      let(:attribute_from_name) { 'og:foo' }

      it { expect(action).to be_truthy }

    end

    context 'with attribute from name not valid' do

      let(:attribute_from_name) { 'foo' }

      before do
        allow(node).to receive(:attribute).with('property').and_return(attribute_from_property)
      end

      context 'and attribute from property valid' do

        let(:attribute_from_property) { 'og:bar' }

        it { expect(action).to be_truthy }

      end

      context 'and attribute from property not valid' do

        let(:attribute_from_property) { 'bar' }

        it { expect(action).to be_falsey }

      end

    end

  end

end
