require 'link_thumbnailer/scrapers/default/base'
require 'link_thumbnailer/models/image'

module LinkThumbnailer
  module Scrapers
    module Default
      class Images < ::LinkThumbnailer::Scrapers::Default::Base

        def value
          abs_urls.each_with_index.take_while { |_, i| i < config.image_limit }.map { |e| modelize(e.first) }
        end

        private

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
          !uri.is_a?(::URI::HTTP)
        end

        def prefix_uri(uri)
          ::URI.join(prefix_url, uri)
        end

        def prefix_url
          base_href || website.url
        end

        def base_href
          base = document.at('//head/base')
          base['href'] if base
        end

        def model_class
          ::LinkThumbnailer::Models::Image
        end

        def modelize(uri)
          model_class.new(uri)
        end

      end
    end
  end
end
