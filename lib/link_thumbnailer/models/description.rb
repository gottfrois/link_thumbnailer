require 'link_thumbnailer/model'
require 'link_thumbnailer/grader'

module LinkThumbnailer
  module Models
    class Description < ::LinkThumbnailer::Model

      attr_reader   :node, :text
      attr_accessor :score

      def initialize(node, text = nil)
        @node  = node
        @text  = sanitize(text || node.text)
        @score = compute_score
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
