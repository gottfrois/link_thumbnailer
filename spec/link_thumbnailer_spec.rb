require 'spec_helper'

describe LinkThumbnailer do

  it { should respond_to :configure }
  it { should respond_to :generate }

  it { should respond_to :mandatory_attributes }
  it { should respond_to :strict }
  it { should respond_to :redirect_limit }
  it { should respond_to :blacklist_urls }
  it { should respond_to :max }
  it { should respond_to :top }

  context "default values" do

    context ".mandatory_attributes" do

      specify { LinkThumbnailer.mandatory_attributes.should eq(%w(url title images)) }

    end

    context ".strict" do

      specify { LinkThumbnailer.strict.should be_true }

    end

    context ".redirect_limit" do

      specify { LinkThumbnailer.redirect_limit.should eq(3) }

    end

    context ".blacklist_urls" do

      specify { LinkThumbnailer.blacklist_urls.should eq([
        %r{^http://ad\.doubleclick\.net/},
        %r{^http://b\.scorecardresearch\.com/},
        %r{^http://pixel\.quantserve\.com/},
        %r{^http://s7\.addthis\.com/}
      ]) }

    end

    context ".max" do

      specify { LinkThumbnailer.max.should eq(10) }

    end

    context ".top" do

      specify { LinkThumbnailer.top.should eq(5) }

    end

  end

  context ".configure" do

    it "should yields self" do
      LinkThumbnailer.should_receive(:configure).and_yield(LinkThumbnailer)
      LinkThumbnailer.configure {|config|}
    end

    context "attributes" do

      before do
        LinkThumbnailer.configure {|config|
          config.mandatory_attributes = %w(foo bar)
          config.strict = false
          config.redirect_limit = 5
          config.blacklist_urls = []
          config.max = 5
          config.top = 10
        }
      end

      specify { LinkThumbnailer.mandatory_attributes.should eq(%w(foo bar)) }
      specify { LinkThumbnailer.strict.should be_false }
      specify { LinkThumbnailer.redirect_limit.should eq(5) }
      specify { LinkThumbnailer.blacklist_urls.should eq([]) }
      specify { LinkThumbnailer.max.should eq(5) }
      specify { LinkThumbnailer.top.should eq(10) }

    end

  end

  context ".generate" do

    context "with invalid arguments" do

      it "should return nil" do
        LinkThumbnailer.generate('foo').should be_nil
      end

    end

  end

end
