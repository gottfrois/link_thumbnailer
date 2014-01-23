require 'link_thumbnailer/version'
require 'link_thumbnailer/configuration'
require 'link_thumbnailer/exceptions'
require 'link_thumbnailer/processor'
require 'link_thumbnailer/parser'
require 'link_thumbnailer/image_comparator'
require 'link_thumbnailer/image_validator'
require 'link_thumbnailer/image_parser'
require 'link_thumbnailer/model'
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
      @scraper ||= ::LinkThumbnailer::Scraper.new(source)
    end

  end

end
