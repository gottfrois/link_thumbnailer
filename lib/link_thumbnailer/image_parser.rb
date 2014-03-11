require 'link_thumbnailer/image_parsers/size'
require 'link_thumbnailer/image_parsers/type'

module LinkThumbnailer
  class ImageParser
    class << self

      def size(image)
        ::LinkThumbnailer::ImageParsers::Size.perform(image)
      end

      def type(image)
        ::LinkThumbnailer::ImageParsers::Type.perform(image)
      end

    end
  end
end
