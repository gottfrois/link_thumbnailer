# frozen_string_literal: true

require 'link_thumbnailer/scrapers/opengraph/base'
require 'link_thumbnailer/scrapers/opengraph/video'

module LinkThumbnailer
  module Scrapers
    module Opengraph
      class Videos < ::LinkThumbnailer::Scrapers::Opengraph::Base

        def call(attribute_name)
          ::LinkThumbnailer::Scrapers::Opengraph::Video.new(document, website).call('video')
        end

      end
    end
  end
end
