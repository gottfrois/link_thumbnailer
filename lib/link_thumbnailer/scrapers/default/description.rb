require 'link_thumbnailer/scrapers/default/base'

module LinkThumbnailer
  module Scrapers
    module Default
      class Description < ::LinkThumbnailer::Scrapers::Default::Base

        private

        def value
          return node_from_meta.attributes['content'].value if node_from_meta
          return node_from_body.text                        if node_from_body

          nil
        end

        def node
          node_from_meta
        end

        def node_from_meta
          meta_xpath(key: :name)
        end

        def node_from_body
          paragraphs.each do |node|
            return node if valid_paragraph?(node)
          end

          nil
        end

        def valid_paragraph?(node)
          !node.has_attribute?('style') && node.first_element_child.nil?
        end

        def paragraphs
          document.css('body p')
        end

      end
    end
  end
end
