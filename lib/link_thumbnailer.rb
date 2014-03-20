require 'link_thumbnailer/version'
require 'link_thumbnailer/configuration'
require 'link_thumbnailer/exceptions'
require 'link_thumbnailer/processor'
require 'link_thumbnailer/parser'
require 'link_thumbnailer/image_comparator'
require 'link_thumbnailer/image_validator'
require 'link_thumbnailer/image_parser'
require 'link_thumbnailer/scraper'

module LinkThumbnailer

  class << self

    attr_reader :processor, :parser, :source

    def generate(url, options = {})
      set_options(options)

      @source = processor.call(url)
      scraper.call
    end

    private

    def set_options(options = {})
      options.each { |k, v| config.send("#{k}=", v) }
    end

    def processor
      @processor ||= ::LinkThumbnailer::Processor.new
    end

    def scraper
      @scraper = ::LinkThumbnailer::Scraper.new(source, processor.url)
    end

  end

end

begin
  require 'rails'
rescue LoadError
end

$stderr.puts <<-EOC if !defined?(Rails)
warning: no framework detected.

Your Gemfile might not be configured properly.
---- e.g. ----
Rails:
    gem 'link_thumbnailer'

EOC

if defined?(Rails)
  # require 'link_thumbnailer/engine'
  # require 'link_thumbnailer/railtie'
end
