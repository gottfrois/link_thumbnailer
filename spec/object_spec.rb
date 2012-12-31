require 'spec_helper'

describe LinkThumbnailer::Object do

  it { should respond_to :valid? }
  it { should respond_to :to_hash }
  it { should respond_to :to_json }

  let(:object) { LinkThumbnailer::Object.new }

  describe ".method_missing" do

    before do
      object[:foo] = 'foo'
    end

    subject { object }

    it { subject.foo.should eq('foo') }
    it { subject.foo?.should be_true }
    it { subject.bar.should be_nil }
    it { subject.bar?.should be_false }

  end

  describe ".valid" do

    before do
      LinkThumbnailer.configure {|config|}
    end

    context "when strict" do

      before do
        LinkThumbnailer.configure { |config| config.strict = true }
      end

      context "and valid" do

        before do
          LinkThumbnailer.configuration.mandatory_attributes.each { |a| object[a] = 'foo' }
        end

        subject { object }

        it { should be_valid }
        it { subject.keys.should eq(LinkThumbnailer.configuration.mandatory_attributes) }
        it { subject.values.should include 'foo' }

      end

      context "and not valid" do

        subject { object }

        it { should_not be_valid }
        it { subject.keys.should be_empty }
        it { subject.values.should be_empty }

      end

    end

    context "when not strict" do

      before do
        LinkThumbnailer.configure { |config| config.strict = false }
      end

      context "and empty" do

        subject { object }

        it { should_not be_valid }
        it { subject.keys.should be_empty }
        it { subject.values.should be_empty }

      end

      context "and not empty" do

        before do
          object[:foo] = 'foo'
        end

        subject { object }

        it { should be_valid }
        it { subject.foo.should eq('foo') }

      end

    end

  end

  context "dealing with WebImage module" do

    class Foo
    end

    let(:foo) { Foo.new }

    before do
      foo.extend LinkThumbnailer::WebImage
      object['images'] = [foo]
    end

    describe ".to_hash" do

      subject { object.to_hash }

      it { subject.is_a?(Hash).should be_true }
      it { should include('images') }
      it { subject['images'].is_a?(Array).should be_true }

    end

    describe ".to_json" do

      subject { object.to_json }

      it { subject.is_a?(String).should be_true }
      it { should include('images') }

    end

  end

end
