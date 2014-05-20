require 'nokogiri'

module LinkThumbnailer
  class Parser

    attr_reader :document

    def call(source)
      @document ||= ::Nokogiri::HTML(source)
    end

  end
end
