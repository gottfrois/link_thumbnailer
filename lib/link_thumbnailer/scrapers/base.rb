module LinkThumbnailer
  module Scrapers
    class Base

      attr_reader :document, :website, :attribute_name

      def initialize(document)
        @document = document
      end

      def call(website, attribute_name)
        @attribute_name = attribute_name

        website.send("#{attribute_name}=", sanitize(value))
        website
      end

      private

      def sanitize(str)
        return unless str
        str.strip
      end

      def meta_xpath(options = {})
        key       = options.fetch(:key, :property)
        value     = options.fetch(:value, :content)
        attribute = options.fetch(:attribute, attribute_name)

        document.xpath("//meta[translate(@#{key},'#{abc.upcase}','#{abc}') = '#{attribute}' and @#{value}]").first
      end

      def abc
        'abcdefghijklmnopqrstuvwxyz'
      end

    end
  end
end


# module LinkThumbnailer
#   module Scrapers
#     class Base

#       attr_reader :handler, :document

#       def initialize(document)
#         @document = document
#         @handler  = handler_class.new(document)
#       end

#       def call(website, attribute_name)
#         handler.call(website, attribute_name)
#       end

#       private

#       # TODO rescue
#       def handler_class
#         if opengraph?
#           "#{self.class.name}::OpengraphHandler".constantize
#         else
#           "#{self.class.name}::DefaultHandler".constantize
#         end
#       end

#       def opengraph?
#         meta.any? do |node|
#           opengraph_node?(node)
#         end
#       end

#       def opengraph_node?(node)
#         property(node).start_with?('og:')
#       end

#       def meta
#         document.css('meta')
#       end

#       # class BaseHandler

#       #   attr_reader :document, :website

#       #   def initialize(document)
#       #     @document = document
#       #   end

#       #   def call(website, attribute_name)
#       #     website.send("#{attribute_name}=", get(attribute_name))
#       #     website
#       #   end

#       #   private

#       #   def meta
#       #     document.css('meta')
#       #   end

#       #   def content(node)
#       #     node.attribute('content').to_s
#       #   end

#       #   def property(node)
#       #     node.attribute('property').to_s
#       #   end

#       #   def sanitize(property)
#       #     underscore(property)
#       #   end

#       #   def underscore(str)
#       #     str.gsub('-', '_')
#       #   end

#       # end

#       # class BaseOpengraphHandler < BaseHandler

#       #   def sanitize(property)
#       #     underscore(property)[3..-1].to_s
#       #   end

#       #   def opengraph_regex
#       #     /^og:(.+)$/i
#       #   end

#       # end

#       # class BaseDefaultHandler < BaseHandler
#       # end

#     end
#   end
# end
