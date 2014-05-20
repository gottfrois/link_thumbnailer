require 'link_thumbnailer/scrapers/opengraph/base'
require 'link_thumbnailer/scrapers/opengraph/image'

module LinkThumbnailer
  module Scrapers
    module Opengraph
      class Images < ::LinkThumbnailer::Scrapers::Opengraph::Base

        def call(website, attribute_name)
          ::LinkThumbnailer::Scrapers::Opengraph::Image.new(document).call(website, 'image')
        end

      end
    end
  end
end
