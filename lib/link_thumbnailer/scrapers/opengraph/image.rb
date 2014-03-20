require 'link_thumbnailer/scrapers/opengraph/base'

module LinkThumbnailer
  module Scrapers
    module Opengraph
      class Image < ::LinkThumbnailer::Scrapers::Opengraph::Base

        private

        def value
          model
        end

        def modelize(node, text = nil)
          model_class.new(text)
        end

      end
    end
  end
end

# o = LinkThumbnailer.generate('http://azendoo.com')
# o = LinkThumbnailer.generate('http://zerply.com')
