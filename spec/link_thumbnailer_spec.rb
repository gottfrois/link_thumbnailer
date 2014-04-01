require 'spec_helper'

describe LinkThumbnailer do

  describe ".generate" do

    let(:options) { {} }
    let(:url)     { 'http://foo.com' }
    let(:action)  { described_class.generate(url, options) }

    before do
      stub_request(:get, url).to_return(status: 200, body: '', headers: {})
    end

    it "should set default options" do
      LinkThumbnailer.should_receive(:set_options).with(options)
      action
    end

  end

  describe '.set_options' do

    def action(options = {})
      described_class.send(:set_options, options)
    end

    it { expect { action(redirect_limit: 5) }.to change           { described_class.config.redirect_limit }.to(5) }
    it { expect { action(user_agent: 'foo') }.to change           { described_class.config.user_agent }.to('foo') }
    it { expect { action(verify_ssl: false) }.to change           { described_class.config.verify_ssl }.to(false) }
    it { expect { action(http_timeout: 10) }.to change            { described_class.config.http_timeout }.to(10) }
    it { expect { action(blacklist_urls: ['foo']) }.to change     { described_class.config.blacklist_urls }.to(['foo']) }
    it { expect { action(attributes: [:foo]) }.to change          { described_class.config.attributes }.to([:foo]) }
    it { expect { action(min_description_length: 50) }.to change  { described_class.config.min_description_length }.to(50) }

  end

end
