# frozen_string_literal: true

require 'link_thumbnailer/scrapers/default/base'
require 'link_thumbnailer/models/favicon'

module LinkThumbnailer
  module Scrapers
    module Default
      class Favicon < ::LinkThumbnailer::Scrapers::Default::Base

        def value
          modelize(to_uri(href)).to_s
        end

        private

        def to_uri(href)
          uri = ::URI.parse(href)
          uri.scheme ||= website.url.scheme
          uri.host ||= website.url.host
          uri.path = uri.path&.sub(%r{^(?=[^\/])}, '/')
          uri
        rescue ::URI::InvalidURIError
          nil
        end

        def href
          node.attributes['href'].value.to_s if node
        end

        def node
          icons = document.xpath("//link[contains(@rel, 'icon')]")
          retrieve_by_size(icons) || icons.first
        end

        def modelize(uri)
          model_class.new(uri)
        end

        def retrieve_by_size(icons)
          return if config.favicon_size.nil?

          icons.find do |icon|
            icon.attributes['sizes']&.value == config.favicon_size
          end
        end
      end
    end
  end
end
