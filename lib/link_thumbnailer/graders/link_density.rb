module LinkThumbnailer
  module Graders
    class LinkDensity < ::LinkThumbnailer::Graders::Base

      def call(current_score)
        return 0 if density_ratio == 0
        current_score *= density_ratio
      end

      private

      def density
        return 0 if text.length == 0
        links.length / text.length.to_f
      end

      def density_ratio
        1 - density
      end

      def links
        node.css('a').map(&:text)
      end

    end
  end
end
