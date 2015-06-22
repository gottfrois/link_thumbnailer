module LinkThumbnailer
  module Graders
    class Length < ::LinkThumbnailer::Graders::Base

      def call
        return 0.0 if too_short?

        y * 1.0 / get_gaussian_value_for(x_pos)
      end

      private

      def get_gaussian_value_for(x)
        (1.0 / 1.0 * Math.sqrt(2.0 * Math::PI ** 2)) * Math.exp(-(x - x_pos) ** 2 / 2.0 * 0.005 ** 2)
      end

      def x
        text.length
      end

      def y
        get_gaussian_value_for(x)
      end

      def x_pos
        80.0
      end

      def too_short?
        text.length < config.description_min_length
      end

    end
  end
end
