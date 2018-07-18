# frozen_string_literal: true

require 'link_thumbnailer/scrapers/default/base'

module LinkThumbnailer
  module Scrapers
    module Default
      class Body < ::LinkThumbnailer::Scrapers::Default::Base

        def value
          model.to_s
        end

        private

        def model
          modelize(node)
        end

        def node
          document.css('body').css('p')
        end

      end
    end
  end
end
