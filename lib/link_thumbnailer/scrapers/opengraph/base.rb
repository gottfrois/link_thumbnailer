require 'link_thumbnailer/scrapers/base'

module LinkThumbnailer
  module Scrapers
    module Opengraph
      class Base < ::LinkThumbnailer::Scrapers::Base

        private

        def value
          model.to_s
        end

        def model
          modelize(node, node.attributes['content'].to_s) if node
        end

        def node
          @node ||= meta_xpath(attribute: attribute) ||
                      meta_xpath(attribute: attribute, key: :name)
        end

        def attribute
          "og:#{attribute_name}"
        end

      end
    end
  end
end
