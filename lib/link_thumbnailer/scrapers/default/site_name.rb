# frozen_string_literal: true

require 'link_thumbnailer/scrapers/default/base'
require 'link_thumbnailer/models/site_name'

module LinkThumbnailer
  module Scrapers
    module Default
      class SiteName < ::LinkThumbnailer::Scrapers::Default::Base
        def value
          nil
        end
      end
    end
  end
end
