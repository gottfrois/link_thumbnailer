module LinkThumbnailer
  module Graders
    class HtmlAttribute < ::LinkThumbnailer::Graders::Base

      attr_reader :attribute_name

      def initialize(config, description, attribute_name)
        super(config, description)
        @attribute_name = attribute_name.to_sym
      end

      def call(previous_score)
        return 0 unless attribute?

        score = 0
        score -= 25 if negative?
        score += 25 if positive?
        score
      end

      private

      def attribute
        node[attribute_name]
      end

      def attribute?
        attribute && !attribute.empty?
      end

      def negative?
        attribute =~ negative_regex
      end

      def positive?
        attribute =~ positive_regex
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