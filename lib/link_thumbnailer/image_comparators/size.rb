# frozen_string_literal: true

module LinkThumbnailer
  module ImageComparators
    class Size < ::LinkThumbnailer::ImageComparators::Base

      def call(other)
        (other.size.min.to_i ** 2) <=> (image.size.min.to_i ** 2)
      end

    end
  end
end
