require 'link_thumbnailer/scrapers/opengraph/base'

module LinkThumbnailer
  module Scrapers
    module Opengraph
      class Image < ::LinkThumbnailer::Scrapers::Opengraph::Base

        def value
          model
        end

        private

        def model
          nodes.map { |n| modelize(n, n.attributes['content'].to_s) }
        end

        def modelize(node, text = nil)
          model_class.new(text, size)
        end

        def nodes
          nodes = meta_xpaths(attribute: attribute)
          nodes.empty? ? meta_xpaths(attribute: attribute, key: :name) : nodes
        end

        def size
          [width.to_i, height.to_i] if width && height
        end

        def width
          Width.new(document).value
        end

        def height
          Height.new(document).value
        end

        class Base < ::LinkThumbnailer::Scrapers::Opengraph::Base

          def value
            node.attributes['content'].to_s if node
          end

        end

        class Width < Base

          private

          def attribute
            "og:image:width"
          end

        end

        class Height < Base

          private

          def attribute
            "og:image:height"
          end

        end

      end
    end
  end
end
