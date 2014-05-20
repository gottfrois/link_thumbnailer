require 'fastimage'

module LinkThumbnailer
  module ImageParsers
    class Size

      def self.perform(image)
        ::FastImage.size(image.src, raise_on_failure: true)
      rescue ::FastImage::FastImageException
        [0, 0]
      end

    end
  end
end
