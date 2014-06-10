require 'fastimage'

module LinkThumbnailer
  module ImageParsers
    class Type

      def self.perform(image)
        return unless perform?
        ::FastImage.type(image.src.to_s, raise_on_failure: true)
      rescue ::FastImage::FastImageException, ::Errno::ENAMETOOLONG
        nil
      end

      private

      def self.perform?
        ::LinkThumbnailer.page.config.image_stats
      end

    end
  end
end
