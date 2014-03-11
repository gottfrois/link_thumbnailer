require 'pry'
require 'delegate'
require 'active_support/inflector'

require 'link_thumbnailer/model'
require 'link_thumbnailer/scrapers/default/title'
require 'link_thumbnailer/scrapers/opengraph/title'
require 'link_thumbnailer/scrapers/default/description'
require 'link_thumbnailer/scrapers/opengraph/description'
require 'link_thumbnailer/scrapers/default/image'
# require 'link_thumbnailer/scrapers/opengraph/image'

module LinkThumbnailer
  class Scraper < ::SimpleDelegator

    class Exception < StandardError; end
    class ScraperInvalid < StandardError; end

    attr_reader :document, :source, :config, :website

    def initialize(source)
      @source   = source
      @config   = ::LinkThumbnailer.config
      @document = parser.call(source)
      @website  = ::LinkThumbnailer::Models::Website.new

      super(config)
    end

    def call
      config.attributes.each do |name|
        scraper = scraper_class(name).new(document)
        scraper.call(website, name.to_s)
      end

      website
    end

    private

    def scraper_class(name)
      scraper_class_name(name.to_s.classify).constantize
    rescue NameError
      raise ScraperInvalid, "scraper named '#{name}' does not exists."
    end

    def scraper_class_name(class_name)
      if opengraph?
        "::LinkThumbnailer::Scrapers::Opengraph::#{class_name}"
      else
        "::LinkThumbnailer::Scrapers::Default::#{class_name}"
      end
    end

    def opengraph?
      meta.any? do |node|
        opengraph_node?(node)
      end
    end

    def opengraph_node?(node)
      node.attribute('property').to_s.start_with?('og:')
    end

    def meta
      document.css('meta')
    end

    def parser
      ::LinkThumbnailer::Parser.new
    end

  end
end
