require 'fastimage'

module LinkThumbnailer
  module ImageParsers
    class Size

      def self.perform(image)
        ::FastImage.size(image.src.to_s, raise_on_failure: true)
      rescue ::FastImage::FastImageException, ::Errno::ENAMETOOLONG
        [0, 0]
      end

    end
  end
end
