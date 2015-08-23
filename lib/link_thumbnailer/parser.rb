require 'nokogiri'

module LinkThumbnailer
  class Parser

    def call(source)
      ::Nokogiri::HTML(source)
    rescue ::Nokogiri::XML::SyntaxError => e
      raise ::LinkThumbnailer::SyntaxError.new(e.message)
    end

  end
end
