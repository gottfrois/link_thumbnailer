module LinkThumbnailer
  module WebImage

    attr_accessor :source_url, :doc

    def to_hash
      result = {}
      LinkThumbnailer.configuration.rmagick_attributes.each {|m|
        k = m.to_sym
        result[k] = self.send(m) if self.respond_to?(m)
        result[k] = result[k].to_s if result[k].is_a?(URI)
      }

      result
    end

  end
end
