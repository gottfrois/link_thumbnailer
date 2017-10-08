module LinkThumbnailer
  module ImageComparators
    class Base

      attr_reader :image

      def initialize(image)
        @image = image
      end

      def call
        fail NotImplementedError
      end

    end
  end
end
