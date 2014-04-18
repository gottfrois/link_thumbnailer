module LinkThumbnailer
  module Graders
    class Base

      attr_reader :config, :description

      def initialize(config, description)
        @config      = config
        @description = description
      end

      def call(previous_score)
        raise 'must implement'
      end

      private

      def node
        description.node
      end

      def text
        node.text
      end

    end
  end
end
