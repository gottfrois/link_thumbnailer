# frozen_string_literal: true

require 'link_thumbnailer/model'

module LinkThumbnailer
  module Models
    class Body < ::LinkThumbnailer::Model

      attr_reader :node, :text

      def initialize(node, text = nil)
        @node = node
        @text = sanitize(node.map(&:text).join(' '))
      end

      def to_s
        text
      end

    end
  end
end
