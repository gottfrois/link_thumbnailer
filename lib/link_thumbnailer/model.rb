module LinkThumbnailer
  class Model

    def to_json(*args)
      as_json.to_json(*args)
    end

    private

    def sanitize(str)
      return unless str
      str.strip.gsub(/[\r\n\f]+/, "\n")
    end

  end
end
