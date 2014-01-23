module LinkThumbnailer
  module Models
    class Image

      attr_reader :src, :type, :size

      def initialize(src)
        @src  = src
        @size = parser.size
        @type = parser.type
      end

      def <=>(other)
        comparator.call(other)
      end

      def valid?
        validator.call
      end

      private

      def parser
        @parser ||= ::LinkThumbnailer::ImageParser.new(self)
      end

      def validator
        @validator ||= ::LinkThumbnailer::ImageValidator.new(self)
      end

      def comparator
        @comparator ||= ::LinkThumbnailer::ImageComparator.new(self)
      end

    end
  end
end
