# frozen_string_literal: true

require 'link_thumbnailer/scrapers/default/base'

module LinkThumbnailer
  module Scrapers
    module Default
      class Body < ::LinkThumbnailer::Scrapers::Default::Base

        def value
          model.paragraphs
        end

        private

        def model
          modelize(node)
        end

        def node
          document.css('body').css('p,h1,h2,h3,h4,h5,h6,blockquote')
        end

      end
    end
  end
end
