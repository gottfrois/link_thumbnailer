require 'spec_helper'

describe LinkThumbnailer::WebImage do

  class Foo
  end

  let(:foo) { Foo.new }

  before do
    foo.extend LinkThumbnailer::WebImage
  end

  subject { foo }

  it { should respond_to :to_json }
  it { should respond_to :source_url }
  it { should respond_to :doc }

  describe ".to_json" do

    context "with default attributes" do

      let(:attributes) { %w(source_url) }

      subject { foo.to_json }

      it { JSON.parse(subject).first.keys.should eq(attributes) }

    end

    context "with all attributes" do

      let(:attributes) { %w(source_url mime_type density colums rows filesize number_colors) }

      before do
        attributes.each {|a| foo.class.send(:define_method, a.to_sym) { 'foo' } }
      end

      subject { foo.to_json }

      it { puts JSON.parse(subject).map {|e| e.keys.first }.should eq(attributes) }
      it { puts JSON.parse(subject).map {|e| e.values.first }.should include('foo') }

    end

  end

end
