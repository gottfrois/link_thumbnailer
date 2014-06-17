require 'fastimage'

module LinkThumbnailer
  module ImageParsers
    class Size

      def self.perform(image)
        return [0, 0] unless perform?
        ::FastImage.size(image.src.to_s, raise_on_failure: true)
      rescue ::FastImage::FastImageException, ::Errno::ENAMETOOLONG
        [0, 0]
      end

      private

      def self.perform?
        ::LinkThumbnailer.page.config.image_stats
      end

    end
  end
end
