require 'fastimage'

module LinkThumbnailer
  module ImageParsers
    class Type

      def self.perform(image)
        ::FastImage.type(image.src, raise_on_failure: true)
      rescue ::FastImage::ImageFetchFailure
        :jpg
      end

    end
  end
end
