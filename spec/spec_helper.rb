require 'simplecov'
require 'coveralls'
Coveralls.wear!

require 'link_thumbnailer'
require 'rspec'
require 'webmock/rspec'
require 'json'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter

RSpec.configure do |config|
end
