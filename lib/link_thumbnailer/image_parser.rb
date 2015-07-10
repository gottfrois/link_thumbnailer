require 'image_info'

module LinkThumbnailer
  class ImageParser

    attr_reader :images

    def initialize(urls)
      @images = perform? ? ::ImageInfo.from(urls, max_concurrency: max_concurrency) : Array(urls).map(&method(:build_default_image))
    end

    def size
      images.first.size
    end

    def type
      images.first.type
    end

    private

    def build_default_image(uri)
      NullImage.new(uri)
    end

    def perform?
      ::LinkThumbnailer.page.config.image_stats
    end

    def max_concurrency
      ::LinkThumbnailer.page.config.max_concurrency
    end

    class NullImage
      attr_reader :uri

      def initialize(uri)
        @uri = uri
      end

      def size
        [0, 0]
      end

      def type
      end
    end

  end
end
