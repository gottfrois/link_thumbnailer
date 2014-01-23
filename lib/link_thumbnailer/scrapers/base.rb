module LinkThumbnailer
  module Scrapers
    class Base

      attr_reader :document, :website, :attributes

      def initialize(document)
        @document   = document
        @attributes = {}
      end

      def call(website)
        @website = website
        scrap

        website
      end

      private

      def content(node)
        node.attribute('content').to_s
      end

      def property(node)
        node.attribute('property').to_s
      end

      def meta
        document.css('meta')
      end

      def sanitize(property)
        underscore(property)
      end

      def underscore(str)
        str.gsub('-', '_')
      end

    end
  end
end

# o = LinkThumbnailer.generate('http://azendoo.com')
