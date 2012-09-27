require 'spec_helper'

describe LinkThumbnailer::WebImage do

  class Foo
  end

  let(:foo) { Foo.new }

  before do
    foo.extend LinkThumbnailer::WebImage
  end

  subject { foo }

  it { should respond_to :to_a }
  it { should respond_to :to_json }
  it { should respond_to :source_url }
  it { should respond_to :doc }

  describe ".to_a" do

    context "with default attributes" do

      let(:attributes) { [:source_url] }

      subject { foo.to_a }

      it { subject.keys.should eq(attributes) }

    end

    context "with all attributes" do

      let(:attributes) { [:source_url, :mime_type, :density, :colums, :rows, :filesize, :number_colors] }

      before do
        attributes.each {|a| foo.class.send(:define_method, a.to_sym) { 'foo' } }
      end

      after do
        attributes.each {|a| foo.class.send(:undef_method, a.to_sym) }
      end

      subject { foo.to_a }

      it { subject.keys.should eq(attributes) }
      it { subject.values.should include('foo') }

    end

  end

  describe ".to_json" do

    context "with default attributes" do

      let(:attributes) { [:source_url] }

      subject { foo.to_json }

      it { JSON.parse(subject).keys.map(&:to_sym).should eq(attributes) }

    end

    context "with all attributes" do

      let(:attributes) { [:source_url, :mime_type, :density, :colums, :rows, :filesize, :number_colors] }

      before do
        attributes.each {|a| foo.class.send(:define_method, a.to_sym) { 'foo' } }
      end

      after do
        attributes.each {|a| foo.class.send(:undef_method, a.to_sym) }
      end

      subject { foo.to_json }

      it { JSON.parse(subject).keys.map(&:to_sym).should eq(attributes) }
      it { JSON.parse(subject).values.should include('foo') }

    end

  end

end
