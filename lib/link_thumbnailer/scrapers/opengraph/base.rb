require 'link_thumbnailer/scrapers/base'

module LinkThumbnailer
  module Scrapers
    module Opengraph
      class Base < ::LinkThumbnailer::Scrapers::Base

        def applicable?
          meta.any? { |node| opengraph_node?(node) }
        end

        def value
          model.to_s
        end

        private

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

        def opengraph_node?(node)
          node.attribute('name').to_s.start_with?('og:') ||
            node.attribute('property').to_s.start_with?('og:')
        end

        def meta
          document.css('meta')
        end

      end
    end
  end
end
