# frozen_string_literal: true

require 'link_thumbnailer/model'

module LinkThumbnailer
  module Models
    class Body < ::LinkThumbnailer::Model

      attr_reader :node, :paragraphs

      def initialize(node, text = nil)
        @node = node
        @paragraphs = node.map{|n| sanitize(squish(n.text.to_s))}
      end

      def to_s
        @paragraphs.join(' ')
      end

    end
  end
end
