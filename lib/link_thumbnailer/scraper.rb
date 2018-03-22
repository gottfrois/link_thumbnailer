# frozen_string_literal: true

require 'delegate'
require 'active_support/core_ext/object/blank'
require 'active_support/inflector'

require 'link_thumbnailer/parser'
require 'link_thumbnailer/models/website'
require 'link_thumbnailer/scrapers/default/title'
require 'link_thumbnailer/scrapers/opengraph/title'
require 'link_thumbnailer/scrapers/default/description'
require 'link_thumbnailer/scrapers/opengraph/description'
require 'link_thumbnailer/scrapers/default/images'
require 'link_thumbnailer/scrapers/opengraph/images'
require 'link_thumbnailer/scrapers/default/videos'
require 'link_thumbnailer/scrapers/opengraph/videos'
require 'link_thumbnailer/scrapers/default/favicon'
require 'link_thumbnailer/scrapers/opengraph/favicon'

module LinkThumbnailer
  class Scraper < ::SimpleDelegator

    attr_reader :document, :source, :url, :config, :website

    def initialize(source, url)
      @source       = source
      @url          = url
      @config       = ::LinkThumbnailer.page.config
      @document     = parser.call(source)
      @website      = ::LinkThumbnailer::Models::Website.new
      @website.url  = url

      super(config)
    end

    def call
      config.attributes.each do |name|
        config.scrapers.each do |scraper_prefix|
          scraper_class(scraper_prefix, name).new(document, website).call(name.to_s)
          break unless website.send(name).blank?
        end
      end

      website
    end

    private

    def scraper_class(prefix, name)
      prefix = "::LinkThumbnailer::Scrapers::#{prefix.to_s.camelize}"
      name = name.to_s.camelize
      "#{prefix}::#{name}".constantize
    rescue NameError
      raise ::LinkThumbnailer::ScraperInvalid, "scraper named '#{prefix}::#{name}' does not exists."
    end

    def parser
      ::LinkThumbnailer::Parser.new
    end

  end
end
