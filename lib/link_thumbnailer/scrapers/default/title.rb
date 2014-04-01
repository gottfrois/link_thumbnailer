require 'link_thumbnailer/scrapers/default/base'

module LinkThumbnailer
  module Scrapers
    module Default
      class Title < ::LinkThumbnailer::Scrapers::Default::Base

        private

        def value
          model.to_s
        end

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
