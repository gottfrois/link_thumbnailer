require 'spec_helper'

describe LinkThumbnailer::Processor do

  let(:page)      { ::LinkThumbnailer::Page.new(url, {}) }
  let(:instance)  { described_class.new }
  let(:url)       { 'http://foo.com' }

  before do
    LinkThumbnailer.stub(:page).and_return(page)
  end

  describe '#call' do

    let(:action) { instance.call(url) }

    context 'when redirect_count is greater than config' do

      it { expect { instance.call(url, 10) } .to raise_error(LinkThumbnailer::RedirectLimit) }

    end

    context 'on no http error' do

      let(:body) { 'foo' }

      before do
        stub_request(:get, url).to_return(status: 200, body: body, headers: {})
      end

      it { expect(action).to eq(body) }

    end

    context 'on http error' do

      before do
        stub_request(:get, url).to_return(status: 500, body: '', headers: {})
      end

      it { expect { action }.to raise_error(LinkThumbnailer::HTTPError) }

    end

    context 'on http redirection' do

      let(:body) { 'foo' }

      context 'with relative uri' do

        let(:another_url) { '/bar' }

        before do
          stub_request(:get, url).to_return(status: 300, body: '', headers: { 'Location' => another_url })
          stub_request(:get, url + another_url).to_return(status: 200, body: body, headers: {})
        end

        it { expect(action).to eq(body) }

      end

      context 'with absolute uri' do

        let(:another_url) { 'http://bar.com' }

        before do
          stub_request(:get, url).to_return(status: 300, body: '', headers: { 'Location' => another_url })
          stub_request(:get, another_url).to_return(status: 200, body: body, headers: {})
        end

        it { expect(action).to eq(body) }

      end

    end

  end

  describe '#with_valid_url' do

    context 'when valid' do

      before do
        instance.stub(:valid_url_format?).and_return(true)
      end

      it 'yields' do
        expect(instance).to receive(:with_valid_url).and_yield
        instance.send(:with_valid_url) {}
      end

    end

    context 'when not valid' do

      before do
        instance.stub(:valid_url_format?).and_return(false)
      end

      it { expect { instance.send(:with_valid_url) }.to raise_error(LinkThumbnailer::BadUriFormat) }

    end

  end

  describe '#set_http_headers' do

    let(:user_agent)  { 'foo' }
    let(:headers)     { instance.send(:http).headers }
    let(:action)      { instance.send(:set_http_headers) }

    before do
      instance.stub(:user_agent).and_return(user_agent)
      action
    end

    it { expect(headers['User-Agent']).to eq(user_agent) }

  end

  describe '#set_http_options' do

    let(:http)    { instance.send(:http) }
    let(:action)  { instance.send(:set_http_options) }

    describe 'verify_mode' do

      context 'when verify_ssl is true' do

        before do
          instance.stub(:ssl_required?).and_return(true)
          action
        end

        it { expect(http.verify_mode).to_not eq(::OpenSSL::SSL::VERIFY_NONE) }

      end

      context 'when verify_ssl is not true' do

        before do
          instance.stub(:ssl_required?).and_return(false)
          action
        end

        it { expect(http.verify_mode).to eq(::OpenSSL::SSL::VERIFY_NONE) }

      end

    end

    describe 'open_timeout' do

      let(:http_open_timeout) { 1 }

      before do
        instance.stub(:http_open_timeout).and_return(http_open_timeout)
        action
      end

      it { expect(http.open_timeout).to eq(http_open_timeout) }

    end

    describe 'read_timeout' do

      let(:http_read_timeout) { 1 }

      before do
        instance.stub(:http_read_timeout).and_return(http_read_timeout)
        action
      end

      it { expect(http.read_timeout).to eq(http_read_timeout) }

    end
  end

  describe '#perform_request' do

    let(:action) { instance.send(:perform_request) }

    before do
      instance.stub_chain(:http, :request).and_return(response)
    end

    context 'when http success' do

      let(:code)      { 200 }
      let(:body)      { 'body' }
      let(:response)  { ::Net::HTTPSuccess.new('', code, body) }

      before do
        response.stub(:body).and_return(body)
      end

      it { expect(action).to eq(body) }

    end

    context 'when http redirection' do

      let(:code)      { 200 }
      let(:body)      { 'body' }
      let(:response)  { ::Net::HTTPRedirection.new('', code, body) }
      let(:new_url)   { 'http://foo.com/bar' }

      before do
        instance.stub(:redirect_count).and_return(0)
        instance.stub(:resolve_relative_url).and_return(new_url)
      end

      it 'calls call method' do
        expect(instance).to receive(:resolve_relative_url)
        expect(instance).to receive(:call).with(new_url, instance.redirect_count + 1, {})
        action
      end

    end

  end

  describe '#build_absolute_url_for' do

    let(:scheme)        { 'https' }
    let(:host)          { 'foo.com' }
    let(:url)           { URI("#{scheme}://#{host}") }
    let(:relative_url)  { '/bar' }
    let(:action)        { instance.send(:build_absolute_url_for, relative_url).to_s }

    before do
      instance.stub(:url).and_return(url)
    end

    it { expect(action).to eq("#{scheme}://#{host}#{relative_url}") }

  end

  describe '#redirect_limit' do

    let(:redirect_limit)  { 1 }
    let(:action)          { instance.send(:redirect_limit) }

    before do
      instance.config.redirect_limit = redirect_limit
    end

    it { expect(action).to eq(redirect_limit) }

  end

  describe '#user_agent' do

    let(:user_agent)  { 'foo' }
    let(:action)      { instance.send(:user_agent) }

    before do
      instance.config.user_agent = user_agent
    end

    it { expect(action).to eq(user_agent) }

  end

  describe '#http_open_timeout' do

    let(:http_open_timeout)  { 1 }
    let(:action)        { instance.send(:http_open_timeout) }

    before do
      instance.config.http_open_timeout = http_open_timeout
    end

    it { expect(action).to eq(http_open_timeout) }

  end

  describe '#http_read_timeout' do

    let(:http_read_timeout)  { 1 }
    let(:action)        { instance.send(:http_read_timeout) }

    before do
      instance.config.http_read_timeout = http_read_timeout
    end

    it { expect(action).to eq(http_read_timeout) }

  end

  describe '#ssl_required?' do

    let(:verify_ssl)  { true }
    let(:action)      { instance.send(:ssl_required?) }

    before do
      instance.config.verify_ssl = verify_ssl
    end

    it { expect(action).to eq(verify_ssl) }

  end

  describe '#valid_url_format?' do

    let(:action) { instance.send(:valid_url_format?) }

    context 'when bad format' do

      before do
        instance.stub(:url).and_return("http://foo.com")
      end

      it { expect(action).to be_falsey }

    end

    context 'when valid format' do

      before do
        instance.stub(:url).and_return(URI("http://foo.com"))
      end

      it { expect(action).to be_truthy }

    end

  end

  describe '#too_many_redirections?' do

    let(:action) { instance.send(:too_many_redirections?) }

    context 'when redirect count is greater than redirect limit' do

      before do
        instance.stub(:redirect_count).and_return(5)
        instance.stub(:redirect_limit).and_return(4)
      end

      it { expect(action).to be_truthy }

    end

    context 'when redirect count is less than redirect limit' do

      before do
        instance.stub(:redirect_count).and_return(4)
        instance.stub(:redirect_limit).and_return(5)
      end

      it { expect(action).to be_falsey }

    end

    context 'when redirect count is equal to redirect limit' do

      before do
        instance.stub(:redirect_count).and_return(5)
        instance.stub(:redirect_limit).and_return(5)
      end

      it { expect(action).to be_falsey }

    end

  end

  describe '#url=' do

    before do
      instance.send(:url=, url)
    end

    it { expect(instance.url).to be_a(URI) }

  end

end
