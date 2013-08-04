require 'rspec'
require 'webmock/rspec'
require 'json'

require 'link_thumbnailer'

require 'coveralls'
Coveralls.wear!

RSpec.configure do |config|
  config.mock_with :rspec
end
