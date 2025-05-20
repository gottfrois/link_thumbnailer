# frozen_string_literal: true

require 'link_thumbnailer'
require 'rspec'
require 'webmock/rspec'

URL = 'http://foo.com'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:all) do
    stub_request(:get, URL).to_return(status: 200, body: 'body', headers: {'Content-Type' => ['text/html; charset=utf-8']})
    ::LinkThumbnailer.generate(URI.parse(URL), {})
  end

end
