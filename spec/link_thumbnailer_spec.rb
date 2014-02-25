require 'spec_helper'

describe LinkThumbnailer do

  let(:og_example)    { File.open(File.dirname(__FILE__) + '/examples/og_example.html').read() }
  let(:example)       { File.open(File.dirname(__FILE__) + '/examples/example.html').read() }
  let(:empty_example) { File.open(File.dirname(__FILE__) + '/examples/empty_example.html').read() }

  it { should respond_to :configuration }
  it { should respond_to :configure }
  it { should respond_to :config }
  it { should respond_to :generate }

  describe ".configure" do

    it "should yields self" do
      LinkThumbnailer.should_receive(:configure).and_yield(LinkThumbnailer)
      LinkThumbnailer.configure {|config|}
    end

    before do
      LinkThumbnailer.configure {|config|
        config.mandatory_attributes = %w(foo bar)
        config.strict               = false
        config.redirect_limit       = 5
        config.blacklist_urls       = []
        config.image_attributes     = []
        config.limit                = 5
        config.top                  = 10
        config.user_agent           = 'linkthumbnailer'
        config.verify_ssl           = true
        config.http_timeout         = 5
      }
    end

    after do
      LinkThumbnailer.configuration = nil
    end

    specify { LinkThumbnailer.configuration.mandatory_attributes.should eq(%w(foo bar)) }
    specify { LinkThumbnailer.configuration.strict.should               be_false }
    specify { LinkThumbnailer.configuration.redirect_limit.should       eq(5) }
    specify { LinkThumbnailer.configuration.blacklist_urls.should       eq([]) }
    specify { LinkThumbnailer.configuration.image_attributes.should     eq([]) }
    specify { LinkThumbnailer.configuration.limit.should                eq(5) }
    specify { LinkThumbnailer.configuration.top.should                  eq(10) }
    specify { LinkThumbnailer.configuration.user_agent.should           eq('linkthumbnailer') }
    specify { LinkThumbnailer.configuration.verify_ssl.should           be_true }
    specify { LinkThumbnailer.configuration.http_timeout.should         eq(5) }

  end

  context "default values" do

    before do
      LinkThumbnailer.configure {|config| }
    end

    specify { LinkThumbnailer.configuration.mandatory_attributes.should eq(%w(url title images)) }
    specify { LinkThumbnailer.configuration.strict.should               be_true }
    specify { LinkThumbnailer.configuration.redirect_limit.should       eq(3) }
    specify { LinkThumbnailer.configuration.blacklist_urls.should       eq([
      %r{^http://ad\.doubleclick\.net/},
      %r{^http://b\.scorecardresearch\.com/},
      %r{^http://pixel\.quantserve\.com/},
      %r{^http://s7\.addthis\.com/}
    ]) }
    specify { LinkThumbnailer.configuration.image_attributes.should     eq(%w(source_url size type)) }
    specify { LinkThumbnailer.configuration.limit.should                eq(10) }
    specify { LinkThumbnailer.configuration.top.should                  eq(5) }
    specify { LinkThumbnailer.configuration.user_agent.should           eq('linkthumbnailer') }
    specify { LinkThumbnailer.configuration.verify_ssl.should           be_true }
    specify { LinkThumbnailer.configuration.http_timeout.should         eq(5) }

  end

  describe ".generate" do

    it "should set default options" do
      LinkThumbnailer.should_receive(:config)
      LinkThumbnailer.generate('foo')
    end

    context "with valid arguments" do

      context "and options" do

        it "should set top option" do
          expect { LinkThumbnailer.generate('foo', top: 20).to change(LinkThumbnailer.configuration.top).from(5).to(20) }
        end

        it "should set limit option" do
          expect { LinkThumbnailer.generate('foo', limit: 20).to change(LinkThumbnailer.configuration.limit).from(10).to(20) }
        end

        it "should set mandatory_attributes option" do
          expect { LinkThumbnailer.generate('foo', mandatory_attributes: %w(one two)).to change(LinkThumbnailer.configuration.mandatory_attributes).from(%w(url title images)).to(%w(one two)) }
        end

        it "should set strict option" do
          expect { LinkThumbnailer.generate('foo', strict: false).to change(LinkThumbnailer.configuration.strict).from(true).to(false) }
        end

        it "should set redirect_limit option" do
          expect { LinkThumbnailer.generate('foo', redirect_limit: 5).to change(LinkThumbnailer.configuration.redirect_limit).from(3).to(5) }
        end

        it "should set blacklist_urls option" do
          expect { LinkThumbnailer.generate('foo', blacklist_urls: [%r{^http://foo\.bar\.com/}]).to change(LinkThumbnailer.configuration.blacklist_urls).to([%r{^http://foo\.bar\.com/}]) }
        end

        it "should set image_attributes option" do
          expect { LinkThumbnailer.generate('foo', image_attributes: %w(one two)).to change(LinkThumbnailer.configuration.image_attributes).to(%w(one two)) }
        end

        it "should set user_agent option" do
          expect { LinkThumbnailer.generate('foo', user_agent: 'Mac Safari').to change(LinkThumbnailer.configuration.mandatory_attributes).from('linkthumbnailer').to('Mac Safari') }
        end

        it "should set verify_ssl option" do
          expect { LinkThumbnailer.generate('foo', verify_ssl: false).to change(LinkThumbnailer.configuration.verify_ssl).from(true).to(false) }
        end

        it "should set http_timeout option" do
          expect { LinkThumbnailer.generate('foo', http_timeout: 2).to change(LinkThumbnailer.configuration.http_timeout).from(5).to(2) }
        end

      end

      context "when strict" do

        context "and not valid" do

          subject { LinkThumbnailer.generate('foo') }

          it { expect(LinkThumbnailer.generate('foo')).to be_nil }

        end

        context "and valid" do

          before do
            stub_request(:get, 'http://foo.com/').to_return(status: 200, body: og_example, headers: {})
          end

          it { expect(LinkThumbnailer.generate('http://foo.com')).to_not be_nil }
          it { expect(LinkThumbnailer.generate('http://foo.com')).to be_valid }

        end

        context "and empty" do

          before do
            stub_request(:get, 'http://foo.com/').to_return(status: 200, body: empty_example, headers: {})
          end

          it { expect(LinkThumbnailer.generate('http://foo.com/')).to be_nil }
          it { expect { LinkThumbnailer.generate('http://foo.com/') }.to_not raise_exception }

        end

      end

      context "when not strict" do

        before do
          LinkThumbnailer.configure {|config| config.strict = false }
        end

        context "and not valid" do

          it { expect(LinkThumbnailer.generate('foo')).to_not be_nil }
          it { expect(LinkThumbnailer.generate('foo')).to be_valid }

        end

        context "and valid" do

          before do
            stub_request(:get, 'http://foo.com/').to_return(status: 200, body: og_example, headers: {})
          end

          it { expect(LinkThumbnailer.generate('http://foo.com')).to_not be_nil }
          it { expect(LinkThumbnailer.generate('http://foo.com')).to be_valid }

        end

        context "and empty" do

          before do
            stub_request(:get, 'http://foo.com/').to_return(status: 200, body: empty_example, headers: {})
          end

          it { expect(LinkThumbnailer.generate('http://foo.com/')).to_not be_nil }
          it { expect { LinkThumbnailer.generate('http://foo.com/') }.to_not raise_exception }

        end

      end

    end

  end

end
