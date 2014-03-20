module LinkThumbnailer
  class Model

    private

    def config
      ::LinkThumbnailer.config
    end

    def sanitize(str)
      return unless str
      str.strip.gsub(/[\r\n\f]+/, "\n")
    end

  end
end
