# frozen_string_literal: true

require 'delegate'

module LinkThumbnailer
  module Graders
    class Base < ::SimpleDelegator

      attr_reader :config, :description, :options

      def initialize(description, options = {})
        @config      = ::LinkThumbnailer.page.config
        @description = description
        @options     = options

        super(config)
      end

      def call
        fail NotImplementedError
      end

      def weight
        options.fetch(:weigth, 1)
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
