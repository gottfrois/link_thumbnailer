# frozen_string_literal: true

module LinkThumbnailer
  module Graders
    class HtmlAttribute < ::LinkThumbnailer::Graders::Base

      attr_reader :attribute_name

      def initialize(description, attribute_name)
        super(description)
        @attribute_name = attribute_name.to_sym
      end

      def call
        return 1.0 if positive?
        return 0.0 if negative?
        1.0
      end

      private

      def attribute
        node[attribute_name]
      end

      def attribute?
        attribute && !attribute.empty?
      end

      def negative?
        attribute? && attribute =~ negative_regex
      end

      def positive?
        attribute? && attribute =~ positive_regex
      end

      def negative_regex
        config.negative_regex
      end

      def positive_regex
        config.positive_regex
      end

    end
  end
end
