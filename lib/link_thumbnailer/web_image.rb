require 'json'

module LinkThumbnailer
  module WebImage

    attr_accessor :source_url, :doc

    def to_a
      result = {}
      %w(source_url mime_type density colums rows filesize number_colors).each {|m|
        result[m.to_sym] = self.send(m) if self.respond_to?(m)
      }

      result
    end

    def to_json
      JSON(self.to_a)
    end

  end
end
