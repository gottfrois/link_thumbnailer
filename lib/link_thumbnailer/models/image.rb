require 'link_thumbnailer/model'

module LinkThumbnailer
  module Models
    class Image < ::LinkThumbnailer::Model

      attr_reader :src, :type, :size

      def initialize(src)
        @src  = src
        @size = parser.size(self)
        @type = parser.type(self)
      end

      def <=>(other)
        comparator.call(other)
      end

      def valid?
        validator.call
      end

      private

      def parser
        ::LinkThumbnailer::ImageParser
      end

      def validator
        ::LinkThumbnailer::ImageValidator.new(self)
      end

      def comparator
        ::LinkThumbnailer::ImageComparator.new(self)
      end

    end
  end
end
