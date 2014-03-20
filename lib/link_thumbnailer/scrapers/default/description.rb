require 'link_thumbnailer/scrapers/default/base'

module LinkThumbnailer
  module Scrapers
    module Default
      class Description < ::LinkThumbnailer::Scrapers::Default::Base

        private

        def value
          return model_from_meta.text if model_from_meta
          return model_from_body.text if model_from_body
          nil
        end

        def model_from_meta
          modelize(node_from_meta, node_from_meta.attributes['content'].value) if node_from_meta
        end

        def model_from_body
          nodes_from_body.map { |node| modelize(node) }.first
        end

        def node_from_meta
          @node_from_meta ||= meta_xpath(key: :name)
        end

        def nodes_from_body
          candidates.select { |node| valid_paragraph?(node) }
        end

        def valid_paragraph?(node)
          !node.has_attribute?('style') && node.first_element_child.nil?
        end

        def candidates
          document.css('body p')
        end

      end
    end
  end
end
