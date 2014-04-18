require 'pry'
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
        @score = ::LinkThumbnailer::Grader.new(self).call
      end

      def to_s
        text
      end

      def <=>(other)
        score <=> other.score
      end

      private

      # def compute_score

      #   @score -= text.split("\n").length
      #   @score += text.split(',').length

      #   parent.score += score if parent
      #   parent.parent.score += score / 2.0 if parent && parent.parent

      # end

    end
  end
end
