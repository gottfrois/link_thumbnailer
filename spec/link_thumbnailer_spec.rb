require 'spec_helper'

describe LinkThumbnailer do

  it { should respond_to :configuration }
  it { should respond_to :configure }
  it { should respond_to :config }
  it { should respond_to :generate }

  describe "configuration" do

    context "#configure" do

      it "should yields self" do
        LinkThumbnailer.should_receive(:configure).and_yield(LinkThumbnailer)
        LinkThumbnailer.configure {|config|}
      end

      before do
        LinkThumbnailer.configure {|config|
          config.mandatory_attributes = %w(foo bar)
          config.strict = false
          config.redirect_limit = 5
          config.blacklist_urls = []
          config.limit = 5
          config.top = 10
        }
      end

      after do
        LinkThumbnailer.configuration = nil
      end

      specify { LinkThumbnailer.configuration.mandatory_attributes.should eq(%w(foo bar)) }
      specify { LinkThumbnailer.configuration.strict.should be_false }
      specify { LinkThumbnailer.configuration.redirect_limit.should eq(5) }
      specify { LinkThumbnailer.configuration.blacklist_urls.should eq([]) }
      specify { LinkThumbnailer.configuration.limit.should eq(5) }
      specify { LinkThumbnailer.configuration.top.should eq(10) }

    end

  end

  context "default values" do

    before do
      LinkThumbnailer.configure {|config| }
    end

    specify { LinkThumbnailer.configuration.mandatory_attributes.should eq(%w(url title images)) }
    specify { LinkThumbnailer.configuration.strict.should be_true }
    specify { LinkThumbnailer.configuration.redirect_limit.should eq(3) }
    specify { LinkThumbnailer.configuration.blacklist_urls.should eq([
      %r{^http://ad\.doubleclick\.net/},
      %r{^http://b\.scorecardresearch\.com/},
      %r{^http://pixel\.quantserve\.com/},
      %r{^http://s7\.addthis\.com/}
    ]) }
    specify { LinkThumbnailer.configuration.limit.should eq(10) }
    specify { LinkThumbnailer.configuration.top.should eq(5) }

  end

  context ".generate" do

    context "with invalid arguments" do

      specify { LinkThumbnailer.generate('foo').should be_nil }

    end

  end

end
