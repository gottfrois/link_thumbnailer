require 'spec_helper'

describe LinkThumbnailer::WebImage do

  class Foo
  end

  let(:foo) { Foo.new }

  before do
    foo.extend LinkThumbnailer::WebImage
  end

  subject { foo }

  it { should respond_to :to_hash }
  it { should respond_to :source_url }
  it { should respond_to :doc }

  describe ".to_hash" do

    context "with default attributes" do

      let(:attributes) { [:source_url] }

      before do
        LinkThumbnailer.config
      end

      subject { foo.to_hash }

      it { subject.keys.should eq(attributes.map(&:to_sym)) }

    end

    context "with all attributes" do

      let(:attributes) { LinkThumbnailer.configuration.fastimage_attributes }

      before do
        attributes.each {|a| foo.class.send(:define_method, a.to_sym) { 'foo' } }
      end

      after do
        attributes.each {|a| foo.class.send(:undef_method, a.to_sym) }
      end

      subject { foo.to_hash }

      it { subject.keys.should eq(attributes.map(&:to_sym)) }
      it { subject.values.should include('foo') }

    end

  end

end
