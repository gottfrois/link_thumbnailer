module LinkThumbnailer
  module WebImage

    attr_accessor :doc

    def source_url
      instance_variable_get(:@uri)
    end

    def to_hash
      LinkThumbnailer.configuration.image_attributes.each_with_object({}) { |m, result|
        k         = m.to_sym
        result[k] = self.send(m)    if self.respond_to?(m)
        result[k] = result[k].to_s  if result[k].is_a?(URI) || result[k].respond_to?(:to_str)
      }
    end

  end
end
