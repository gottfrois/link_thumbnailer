# frozen_string_literal: true

module LinkThumbnailer
  class Model

    def to_json(*args)
      as_json.to_json(*args)
    end

    private

    def sanitize(str)
      return unless str

      str = str.dup
      str.encode!("UTF-16", "UTF-8", invalid: :replace, undef: :replace, replace: "")
      str.encode!("UTF-8", "UTF-16").strip.gsub(/[\r\n\f]+/, "\n")
    end
  end
end
