require 'link_thumbnailer/image_parsers/base'
require 'link_thumbnailer/image_parsers/size'
require 'link_thumbnailer/image_parsers/type'

module LinkThumbnailer
  class ImageParser

    attr_reader :image

    def initialize(image)
      @image = image
    end

    def size
      ::LinkThumbnailer::ImageParsers::Size.new(image).call
    end

    def type
      ::LinkThumbnailer::ImageParsers::Type.new(image).call
    end

  end
end
