require 'fastimage'

module LinkThumbnailer
  module ImageParsers
    class Type

      def self.perform(image)
        ::FastImage.type(image.src.to_s, raise_on_failure: true)
      rescue ::FastImage::FastImageException, ::Errno::ENAMETOOLONG
        :jpg
      end

    end
  end
end
