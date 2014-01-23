require 'nokogiri'

module LinkThumbnailer
  class Parser

    attr_reader :source, :html

    def call(source)
      @source = source
      @html   = ::Nokogiri::HTML(source)
    end

  end
end
