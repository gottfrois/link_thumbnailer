module LinkThumbnailer
  module Graders
    class Position < ::LinkThumbnailer::Graders::Base

      def call(current_score)
        2.0 / description.position
      end

    end
  end
end
