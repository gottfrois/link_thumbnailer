module LinkThumbnailer
  module Graders
    class PunctuationDensity < ::LinkThumbnailer::Graders::Base

      def call
        return 0.0 if text.length == 0
        1.0 - (punctuations.count.to_f / text.length.to_f)
      end

      private

      def punctuations
        text.scan(regex)
      end

      def regex
        /(\.[^A-Za-z0-9]|,[^0-9]|!|\?|\n|\+|\[|\]|\/)/
      end

    end
  end
end
