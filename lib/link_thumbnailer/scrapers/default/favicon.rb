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
          ::URI.parse(href)
        rescue ::URI::InvalidURIError
          nil
        end

        def href
          node.attributes['href'].value.to_s if node
        end

        def node
          document.xpath("//link[contains(@rel, 'icon')]").first
        end

        def modelize(uri)
          model_class.new(uri)
        end

      end
    end
  end
end
