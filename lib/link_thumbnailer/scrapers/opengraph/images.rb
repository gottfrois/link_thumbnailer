# frozen_string_literal: true

require 'link_thumbnailer/scrapers/opengraph/base'
require 'link_thumbnailer/scrapers/opengraph/image'

module LinkThumbnailer
  module Scrapers
    module Opengraph
      class Images < ::LinkThumbnailer::Scrapers::Opengraph::Base

        def call(attribute_name)
          ::LinkThumbnailer::Scrapers::Opengraph::Image.new(document, website).call('image')
        end

      end
    end
  end
end
