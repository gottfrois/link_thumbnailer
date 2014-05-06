require 'link_thumbnailer/processor'
require 'link_thumbnailer/scraper'

module LinkThumbnailer
  class Page

    attr_reader :url, :options, :source

    def initialize(url, options = {})
      @url     = url
      @options = options

      set_options
    end

    def generate
      @source = processor.call(url)
      scraper.call
    end

    def config
      @config ||= ::LinkThumbnailer.config.dup
    end

    private

    def set_options
      options.each { |k, v| config.send("#{k}=", v) }
    end

    def processor
      @processor ||= ::LinkThumbnailer::Processor.new
    end

    def scraper
      @scraper ||= ::LinkThumbnailer::Scraper.new(source, processor.url)
    end

  end
end
