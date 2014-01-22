require 'fastimage'

module LinkThumbnailer

  class ImgParser

    def initialize(fetcher, img_url_filter)
      @fetcher          = fetcher
      @img_url_filters  = [*img_url_filter]
    end

    def parse(img_urls)
      @img_url_filters.each do |filter|
        img_urls.delete_if { |i| filter.reject?(i) }
      end

      imgs  = []
      count = 0
      img_urls.each { |i|
        break if count >= LinkThumbnailer.configuration.limit
        img = parse_one(i)
        next unless img
        img.extend LinkThumbnailer::ImgComparator
        imgs << img
        count += 1
      }

      imgs.sort! unless imgs.count <= 1

      imgs.first(LinkThumbnailer.configuration.top)
    end

    def parse_one(img_url)
      img = FastImage.new(img_url, :raise_on_failure => false)
      if !img.respond_to?(:source_url)
        class <<img
          def source_url
            return @parsed_uri
          end
        end
      end
      img
    rescue StandardError
      nil
    end

  end

end
