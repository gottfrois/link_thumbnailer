require 'delegate'
require 'link_thumbnailer/scrapers/base'
require 'link_thumbnailer/scrapers/opengraph'
require 'link_thumbnailer/scrapers/text'

module LinkThumbnailer
  class Scraper < ::SimpleDelegator

    attr_reader :document, :source, :config, :scrapers, :website

    def initialize(source)
      @source   = source
      @config   = ::LinkThumbnailer.config
      @document = parser.call(source)
      @scrapers = instantiate_scrapers
      @website  = ::LinkThumbnailer::Models::Website.new

      super(config)
    end

    def call
      scrapers.each do |s|
        s.call(website)
      end

      website
    end

    private

    def instantiate_scrapers
      available_scrapers.map do |klass|
        klass.new(document) if selected?(klass)
      end.compact
    end

    def selected?(klass)
      config.scrapers.include?(scraper_name(klass))
    end

    def scraper_name(klass)
      klass.name.split('::').last.downcase.to_sym
    end

    def available_scrapers
      [
        ::LinkThumbnailer::Scrapers::Opengraph,
        ::LinkThumbnailer::Scrapers::Text
      ]
    end

    def parser
      ::LinkThumbnailer::Parser.new
    end

  end
end
