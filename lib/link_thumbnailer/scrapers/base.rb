require 'link_thumbnailer/models/title'
require 'link_thumbnailer/models/description'
require 'link_thumbnailer/models/image'

module LinkThumbnailer
  module Scrapers
    class Base

      attr_reader :document, :website, :attribute_name

      def initialize(document)
        @document = document
      end

      def call(website, attribute_name)
        @website        = website
        @attribute_name = attribute_name

        website.send("#{attribute_name}=", value)
        website
      end

      def applicable?
        true
      end

      private

      def value
        raise 'must implement'
      end

      def meta_xpath(options = {})
        meta_xpaths(options).first
      end

      def meta_xpaths(options = {})
        key       = options.fetch(:key, :property)
        value     = options.fetch(:value, :content)
        attribute = options.fetch(:attribute, attribute_name)

        document.xpath("//meta[translate(@#{key},'#{abc.upcase}','#{abc}') = '#{attribute}' and @#{value}]")
      end

      def abc
        'abcdefghijklmnopqrstuvwxyz'
      end

      def model_class
        "::LinkThumbnailer::Models::#{attribute_name.to_s.camelize}".constantize
      end

      def modelize(node, text = nil)
        model_class.new(node, text)
      end

    end
  end
end
