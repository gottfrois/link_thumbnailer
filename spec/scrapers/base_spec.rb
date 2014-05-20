require 'spec_helper'

describe LinkThumbnailer::Scrapers::Base do

  let(:document) { double('document') }
  let(:instance) { described_class.new(document) }

  describe '#call' do

    let(:website) { LinkThumbnailer::Models::Website.new }
    let(:attr)    { :title }
    let(:value)   { 'foo' }
    let(:action)  { instance.call(website, attr) }

    before do
      instance.stub(:value).and_return(value)
    end

    it { expect { action }.to change { website.title }.from(nil).to(value) }

  end

  describe '#model_class' do

    let(:action) { instance.send(:model_class) }

    before do
      instance.stub(:attribute_name).and_return(attr)
    end

    context 'when internal class exists' do

      let(:attr) { :title }

      it { expect(action).to eq(::LinkThumbnailer::Models::Title) }

    end

    context 'when internal class does not exists' do

      let(:attr) { :foo }

      it { expect { action }.to raise_exception }

    end

  end

  describe '#modelize' do

    let(:node)        { double('node') }
    let(:text)        { 'foo' }
    let(:model_class) { double('model_class') }
    let(:action)      { instance.send(:modelize, node, text) }

    before do
      instance.stub(:model_class).and_return(model_class)
    end

    it 'instantiates a new model' do
      expect(model_class).to receive(:new).with(node, text)
      action
    end

  end

end
