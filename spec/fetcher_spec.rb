require 'spec_helper'

describe LinkThumbnailer::Fetcher do

  it { should respond_to :fetch }

  let(:fetcher) { LinkThumbnailer::Fetcher.new }

  describe ".fetch" do

    before do
      LinkThumbnailer.configure {|config| config.redirect_count = 3}
    end

    context "when redirect_count is more than config" do

      it { lambda { fetcher.fetch('http://foo.com', 10) }.should raise_exception(ArgumentError) }

    end

    context "when no http error" do

      before do
        stub_request(:get, 'http://foo.com/').to_return(:status => 200, :body => 'foo', :headers => {})
      end

      subject { fetcher.fetch('http://foo.com') }

      it { should eq('foo') }

    end

    context "when http error" do

      before do
        stub_request(:get, 'http://foo.com/').to_return(:status => 500, :body => 'foo', :headers => {})
      end

      it { lambda { fetcher.fetch('http://foo.com') }.should raise_exception(Net::HTTPFatalError) }

    end

  end

end
