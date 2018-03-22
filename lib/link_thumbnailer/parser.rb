# frozen_string_literal: true

require 'nokogiri'

module LinkThumbnailer
  class Parser

    def call(source)
      ::Nokogiri::HTML(source, nil, LinkThumbnailer.page.config.encoding)
    rescue ::Nokogiri::XML::SyntaxError => e
      raise ::LinkThumbnailer::SyntaxError.new(e.message)
    end

  end
end
