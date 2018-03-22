# frozen_string_literal: true

module LinkThumbnailer
  module Graders
    class Position < ::LinkThumbnailer::Graders::Base

      def call
        1.0 - (description.position.to_f / description.candidates_number.to_f)
      end

    end
  end
end
