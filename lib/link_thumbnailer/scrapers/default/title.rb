require 'link_thumbnailer/scrapers/default/base'

module LinkThumbnailer
  module Scrapers
    module Default
      class Title < ::LinkThumbnailer::Scrapers::Default::Base

        def value
          model.to_s
        end

        private

        def model
          modelize(node)
        end

        def node
          document.css(attribute_name)
        end

      end
    end
  end
end
