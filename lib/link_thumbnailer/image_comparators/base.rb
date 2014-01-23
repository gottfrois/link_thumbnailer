module LinkThumbnailer
  module ImageComparators
    class Base

      attr_reader :image

      def initialize(image)
        @image = image
      end

      def call
        raise 'you must implement this method'
      end

    end
  end
end
