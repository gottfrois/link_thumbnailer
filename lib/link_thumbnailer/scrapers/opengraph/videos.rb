require 'link_thumbnailer/scrapers/opengraph/base'
require 'link_thumbnailer/scrapers/opengraph/video'

module LinkThumbnailer
  module Scrapers
    module Opengraph
      class Videos < ::LinkThumbnailer::Scrapers::Opengraph::Base

        def call(website, attribute_name)
          ::LinkThumbnailer::Scrapers::Opengraph::Video.new(document).call(website, 'video')
        end

      end
    end
  end
end
