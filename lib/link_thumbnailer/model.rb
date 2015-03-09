module LinkThumbnailer
  class Model

    def to_json(*args)
      as_json.to_json(*args)
    end

    private

    def sanitize(str)
      return unless str
      str.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '').strip.gsub(/[\r\n\f]+/, "\n")
    end

  end
end
