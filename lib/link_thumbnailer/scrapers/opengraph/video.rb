# frozen_string_literal: true

require 'link_thumbnailer/scrapers/opengraph/base'

module LinkThumbnailer
  module Scrapers
    module Opengraph
      class Video < ::LinkThumbnailer::Scrapers::Opengraph::Base

        def value
          ::LinkThumbnailer::Scrapers::Opengraph::Video::Base.new(document, website).value +
          ::LinkThumbnailer::Scrapers::Opengraph::Video::Url.new(document, website).value
        end

        private

        # Handles `og:video` attributes.
        class Base < ::LinkThumbnailer::Scrapers::Opengraph::Base

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

          def model_class
            ::LinkThumbnailer::Models::Video
          end

          def nodes
            nodes = meta_xpaths(attribute: attribute)
            nodes.empty? ? meta_xpaths(attribute: attribute, key: :name) : nodes
          end

          def attribute
            return 'og:url' if vimeo?
            'og:video'
          end

          # Vimeo uses a SWF file for its og:video property which doesn't
          # provide any metadata for the VideoInfo gem downstream. Using
          # og:url means VideoInfo is passed a webpage URL with metadata
          # it can parse.
          def vimeo?
            website.url.host =~ /vimeo/
          end

          def size
            [width.to_i, height.to_i] if width && height
          end

          def width
            ::LinkThumbnailer::Scrapers::Opengraph::Video::Width.new(document).value
          end

          def height
            ::LinkThumbnailer::Scrapers::Opengraph::Video::Height.new(document).value
          end

        end

        # Handles `og:video:url` attributes.
        class Url < ::LinkThumbnailer::Scrapers::Opengraph::Video::Base

          private

          def attribute
            super
            'og:video:url'
          end

        end

        # Handles `og:video:width` attributes.
        class Width < ::LinkThumbnailer::Scrapers::Opengraph::Base

          def value
            node.attributes['content'].to_s if node
          end

          private

          def attribute
            'og:video:width'
          end

        end

        # Handles `og:video:height` attributes.
        class Height < ::LinkThumbnailer::Scrapers::Opengraph::Base

          def value
            node.attributes['content'].to_s if node
          end

          private

          def attribute
            'og:video:height'
          end

        end

      end
    end
  end
end
