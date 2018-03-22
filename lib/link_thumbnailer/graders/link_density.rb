# frozen_string_literal: true

module LinkThumbnailer
  module Graders
    class LinkDensity < ::LinkThumbnailer::Graders::Base

      def call
        return 0.0 if text.length == 0
        1.0 - (links.count.to_f / text.length.to_f)
      end

      private

      def links
        node.css('a').map(&:text).compact.reject(&:empty?)
      end

    end
  end
end
