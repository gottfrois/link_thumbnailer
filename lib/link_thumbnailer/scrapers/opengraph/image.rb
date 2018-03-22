# frozen_string_literal: true

require 'link_thumbnailer/scrapers/opengraph/base'
require 'link_thumbnailer/uri'

module LinkThumbnailer
  module Scrapers
    module Opengraph
      class Image < ::LinkThumbnailer::Scrapers::Opengraph::Base

        def value
          ::LinkThumbnailer::Scrapers::Opengraph::Image::Base.new(document, website).value +
          ::LinkThumbnailer::Scrapers::Opengraph::Image::Url.new(document, website).value
        end

        private

        # Handles `og:image` attributes.
        class Base < ::LinkThumbnailer::Scrapers::Opengraph::Base

          def value
            model
          end

          def model
            nodes.map do |n|
              uri =  LinkThumbnailer::URI.new(n.attributes['content'])
              modelize(n, uri.to_s) if uri.valid?
            end.compact
          end

          def modelize(node, text = nil)
            model_class.new(text, size)
          end

          def model_class
            ::LinkThumbnailer::Models::Image
          end

          def nodes
            nodes = meta_xpaths(attribute: attribute)
            nodes.empty? ? meta_xpaths(attribute: attribute, key: :name) : nodes
          end

          def attribute
            'og:image'
          end

          def size
            [width.to_i, height.to_i] if width && height
          end

          def width
            ::LinkThumbnailer::Scrapers::Opengraph::Image::Width.new(document).value
          end

          def height
            ::LinkThumbnailer::Scrapers::Opengraph::Image::Height.new(document).value
          end

        end

        # Handles `og:image:url` attributes.
        class Url < ::LinkThumbnailer::Scrapers::Opengraph::Image::Base

          private

          def attribute
            'og:image:url'
          end

        end

        # Handles `og:image:width` attributes.
        class Width < ::LinkThumbnailer::Scrapers::Opengraph::Base

          def value
            node.attributes['content'].to_s if node
          end

          private

          def attribute
            'og:image:width'
          end

        end

        # Handles `og:image:height` attributes.
        class Height < ::LinkThumbnailer::Scrapers::Opengraph::Base

          def value
            node.attributes['content'].to_s if node
          end

          private

          def attribute
            'og:image:height'
          end

        end

      end
    end
  end
end
