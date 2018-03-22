# frozen_string_literal: true

module LinkThumbnailer
  class URI

    attr_reader :attribute

    def initialize(uri)
      @attribute = uri.to_s
    end

    def valid?
      !!(attribute =~ ::URI::regexp)
    end

    def to_s
      attribute
    end
  end
end
