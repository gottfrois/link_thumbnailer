require 'link_thumbnailer/model'

module LinkThumbnailer
  module Models
    class Title < ::LinkThumbnailer::Model

      attr_reader :node, :text

      def initialize(node, text = nil)
        @node = node
        @text = sanitize(text || node.text)
      end

      def to_s
        text
      end

    end
  end
end
