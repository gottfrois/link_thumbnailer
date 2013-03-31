require 'spec_helper'

describe LinkThumbnailer::Fetcher do

  it { should respond_to :fetch }
  it { should respond_to :url }
  it { should respond_to :url= }

  let(:fetcher) { LinkThumbnailer::Fetcher.new }
  let(:url) { 'http://foo.com' }

  describe ".fetch" do

    before do
      LinkThumbnailer.configure {|config| config.redirect_count = 3}
    end

    context "when redirect_count is more than config" do

      it { lambda { fetcher.fetch(url, 10) }.should raise_exception(ArgumentError) }

    end

    context "when no http error" do

      before do
        stub_request(:get, url).to_return(:status => 200, :body => 'foo', :headers => {})
      end

      it "returns body response" do
        fetcher.fetch(url).should eq('foo')
      end

      it "sets fetcher url" do
        fetcher.fetch(url)
        fetcher.url.to_s.should eq(url)
      end

    end

    context "when http redirection" do

      let(:another_url) { 'http://bar.com' }

      before do
        stub_request(:get, url).to_return(:status => 300, :body => 'foo', :headers => { 'Location' =>  another_url})
        stub_request(:get, another_url).to_return(:status => 200, :body => 'bar', :headers => {})
      end

      it "returns body response" do
        fetcher.fetch(url).should eq('bar')
      end

      it "sets fetcher url" do
        fetcher.fetch(url)
        fetcher.url.to_s.should eq(another_url)
      end

    end

    context "when http error" do

      before do
        stub_request(:get, url).to_return(:status => 500, :body => 'foo', :headers => {})
      end

      it { lambda { fetcher.fetch(url) }.should raise_exception(Net::HTTPFatalError) }

    end

  end

end
