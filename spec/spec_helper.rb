require 'simplecov'
require 'coveralls'
Coveralls.wear!

require 'link_thumbnailer'
require 'rspec'
require 'webmock/rspec'

SimpleCov.formatter = Coveralls::SimpleCov::Formatter

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
