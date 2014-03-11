require 'link_thumbnailer/image_comparators/base'
require 'link_thumbnailer/image_comparators/size'

module LinkThumbnailer
  class ImageComparator

    attr_reader :image

    def initialize(image)
      @image = image
    end

    def call(other)
      size_comparator.call(other)
    end

    private

    def size_comparator
      ::LinkThumbnailer::ImageComparators::Size.new(image)
    end

  end
end
