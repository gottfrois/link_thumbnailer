require 'json'

module LinkThumbnailer
  module WebImage

    attr_accessor :source_url
    attr_accessor :doc

    def to_json
      result = []
      %w(source_url mime_type density colums rows filesize number_colors).each {|m|
        result << { m.to_sym => self.send(m) } if self.respond_to?(m)
      }

      JSON(result)
    end

  end
end
