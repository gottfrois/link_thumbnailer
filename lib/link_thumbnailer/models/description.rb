require 'link_thumbnailer/model'
require 'link_thumbnailer/grader'

module LinkThumbnailer
  module Models
    class Description < ::LinkThumbnailer::Model

      attr_reader   :node, :text, :position
      attr_accessor :score

      def initialize(node, text = nil, position = 1)
        @node     = node
        @text     = sanitize(text || node.text)
        @position = position
        @score    = compute_score
      end

      def to_s
        text
      end

      def <=>(other)
        score <=> other.score
      end

      private

      def compute_score
        ::LinkThumbnailer::Grader.new(self).call
      end

    end
  end
end
