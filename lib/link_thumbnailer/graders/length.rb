module LinkThumbnailer
  module Graders
    class Length < ::LinkThumbnailer::Graders::Base

      def call(current_score)
        return -Float::INFINITY if too_short?

        [(text.length / 100).to_i, 3].min
      end

      private

      def too_short?
        text.length < config.description_min_length
      end

    end
  end
end
