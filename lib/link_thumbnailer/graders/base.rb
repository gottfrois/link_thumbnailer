require 'delegate'

module LinkThumbnailer
  module Graders
    class Base < ::SimpleDelegator

      attr_reader :config, :description

      def initialize(description)
        @config      = ::LinkThumbnailer.page.config
        @description = description

        super(config)
      end

      def call
        fail NotImplementedError
      end

      private

      def node
        description.node
      end

      def text
        description.text
      end

    end
  end
end
