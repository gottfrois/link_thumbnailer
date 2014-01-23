module LinkThumbnailer
  module Scrapers
    class Opengraph < ::LinkThumbnailer::Scrapers::Base

      attr_reader :mapper

      def initialize(document)
        super
        @mapper = ::LinkThumbnailer::Scrapers::Opengraph::Mapper.new
      end

      def scrap
        build_mapper
        build_website
      end

      private

      def build_mapper
        meta.each do |node|
          next unless opengraph_node?(node)
          begin

          rescue NoMethodError
          end
        end
      end

      def build_website
      end

      def sanitize(property)
        underscore(property)[3..-1].to_s
      end

      def opengraph_node?(node)
        property(node).start_with?('og')
      end

      def opengraph_regex
        /^og:(.+)$/i
      end

      class Mapper

        # def title=(content)
        #   return if content.nil? || content.empty?
        #   @title = ::LinkThumbnailer::Models::Element.new(content, :h1)
        # end

        # def description=(content)
        #   return if content.nil? || content.empty?
        #   @description = ::LinkThumbnailer::Models::Element.new(content, :p)
        # end

        # def image=(content)
        #   return if content.nil? || content.empty?
        #   @images.push(::LinkThumbnailer::Models::Image.new(content))
        # end

      end

    end
  end
end
