require 'link_thumbnailer/scrapers/base'

module LinkThumbnailer
  module Scrapers
    module Opengraph
      class Base < ::LinkThumbnailer::Scrapers::Base

        private

        def value
          node.attributes['content'].to_s
        end

        def node
          meta_xpath(attribute: attribute) ||
          meta_xpath(attribute: attribute, key: :name)
        end

        def attribute
          "og:#{attribute_name}"
        end

        def underscorize(str)
          str.gsub('-', '_')
        end

      end
    end
  end
end
