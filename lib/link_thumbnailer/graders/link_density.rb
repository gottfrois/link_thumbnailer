module LinkThumbnailer
  module Graders
    class LinkDensity < ::LinkThumbnailer::Graders::Base

      def call(current_score)
        current_score *= (1 - density)
      end

      private

      def density
        return 0 if text.length == 0
        links.length / text.length.to_f
      end

      def links
        node.css('a').map(&:text)
      end

    end
  end
end
