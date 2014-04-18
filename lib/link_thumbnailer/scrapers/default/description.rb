require 'link_thumbnailer/scrapers/default/base'

module LinkThumbnailer
  module Scrapers
    module Default
      class Description < ::LinkThumbnailer::Scrapers::Default::Base

        private

        def value
          return model_from_meta.to_s if model_from_meta
          return model_from_body.to_s if model_from_body
          nil
        end

        def model_from_meta
          modelize(node_from_meta, node_from_meta.attributes['content'].value) if node_from_meta
        end

        def model_from_body
          nodes_from_body.map { |node| modelize(node) }.sort.last
        end

        def node_from_meta
          @node_from_meta ||= meta_xpath(key: :name)
        end

        def nodes_from_body
          candidates.select { |node| valid_paragraph?(node) }
        end

        def valid_paragraph?(node)
          true
        end

        def candidates
          document.css('p,td')
        end

      end
    end
  end
end
