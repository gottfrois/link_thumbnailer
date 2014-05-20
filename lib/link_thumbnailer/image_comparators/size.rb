module LinkThumbnailer
  module ImageComparators
    class Size < ::LinkThumbnailer::ImageComparators::Base

      def call(other)
        (other.size.min ** 2) <=> (image.size.min ** 2)
      end

    end
  end
end
