module LinkThumbnailer
  module Graders
    class Length < ::LinkThumbnailer::Graders::Base

      def call
        return 0.0 if too_short?

        y / ideal_description_gaussian_value
      end

      private

      def get_gaussian_value_for(x)
        Math.sqrt(2.0 * Math::PI ** 2) * Math.exp(-(x - ideal_description_length) ** 2 / 2.0 * 0.005 ** 2)
      end

      def x
        text.length
      end

      def y
        get_gaussian_value_for(x)
      end

      def ideal_description_length
        120.0
      end

      def ideal_description_gaussian_value
        4.442882938158366
      end

      def too_short?
        text.length < config.description_min_length
      end

    end
  end
end
