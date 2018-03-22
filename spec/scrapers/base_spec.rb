# frozen_string_literal: true

require 'spec_helper'

describe LinkThumbnailer::Scrapers::Base do

  let(:document) { double('document') }
  let(:website)  { LinkThumbnailer::Models::Website.new }
  let(:instance) { described_class.new(document, website) }

  describe '#call' do

    let(:attr)    { :title }
    let(:value)   { 'foo' }
    let(:action)  { instance.call(attr) }

    before do
      allow(instance).to receive(:value).and_return(value)
    end

    it { expect { action }.to change { website.title }.from(nil).to(value) }

  end

  describe '#model_class' do

    let(:action) { instance.send(:model_class) }

    before do
      allow(instance).to receive(:attribute_name).and_return(attr)
    end

    context 'when internal class exists' do

      let(:attr) { :title }

      it { expect(action).to eq(::LinkThumbnailer::Models::Title) }

    end

    context 'when internal class does not exists' do

      let(:attr) { :foo }

      it { expect { action }.to raise_error(NameError) }

    end

  end

  describe '#modelize' do

    let(:node)        { double('node') }
    let(:text)        { 'foo' }
    let(:model_class) { double('model_class') }
    let(:action)      { instance.send(:modelize, node, text) }

    before do
      allow(instance).to receive(:model_class).and_return(model_class)
    end

    it 'instantiates a new model' do
      expect(model_class).to receive(:new).with(node, text)
      action
    end

  end

end
