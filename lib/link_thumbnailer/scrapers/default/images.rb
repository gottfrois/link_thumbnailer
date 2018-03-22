# frozen_string_literal: true

require 'link_thumbnailer/scrapers/default/base'
require 'link_thumbnailer/models/image'

module LinkThumbnailer
  module Scrapers
    module Default
      class Images < ::LinkThumbnailer::Scrapers::Default::Base

        def value
          images.map do |image|
            modelize(image.uri, image.size, image.type)
          end
        end

        private

        def images
          ::LinkThumbnailer::ImageParser.new(allowed_urls).images
        end

        def allowed_urls
          abs_urls.shift(config.image_limit)
        end

        def urls
          document.search('//img').map { |i| i['src'] }.compact
        end

        def abs_urls
          urls.map do |url|
            uri = validate_url(url)

            next unless uri

            uri = prefix_uri(uri) if needs_prefix?(uri)
            uri
          end
        end

        def validate_url(url)
          ::URI.parse(url.to_s)
        rescue ::URI::InvalidURIError
          nil
        end

        def needs_prefix?(uri)
          !uri.host
        end

        def prefix_uri(uri)
          ::URI.join(prefix_url, uri)
        end

        def prefix_url
          base_href || website.url
        end

        def base_href
          base = document.at('//head/base')
          base['href'] if base && ::URI.parse(base['href']).host
        rescue ::URI::InvalidURIError
          nil
        end

        def model_class
          ::LinkThumbnailer::Models::Image
        end

        def modelize(uri, size = nil, type = nil)
          model_class.new(uri, size, type)
        end

      end
    end
  end
end
