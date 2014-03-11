require 'link_thumbnailer/scrapers/default/base'

module LinkThumbnailer
  module Scrapers
    module Default
      class Image < ::LinkThumbnailer::Scrapers::Default::Base

        private

        def value
          # todo
        end

        # todo
        def sanitize(urls)
          urls.map do |url|
            ::LinkThumbnailer::Models::Image.new(url)
          end
        end

        def urls
          document.search('//img').map { |i| i['src'] }.compact
        end

        def abs_urls
          urls.each_with_object([]) do |url, a|
            # todo
          end
        end

      end
    end
  end
end
