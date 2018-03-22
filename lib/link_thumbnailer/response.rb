# frozen_string_literal: true

module LinkThumbnailer
  class Response
    def initialize(response)
      @response = response
    end

    def charset
      @charset ||= extract_charset
    end

    def body
      @body ||= extract_body
    end

    private

    def extract_charset
      content_type = @response['Content-Type'] || ''
      m = content_type.match(/charset=(\w+)/)
      (m && m[1]) || ''
    end

    def extract_body
      should_convert_body_to_utf8? ? convert_encoding_to_utf8(@response.body, charset) : @response.body
    end

    def should_convert_body_to_utf8?
      charset != '' && charset != 'utf-8'
    end

    def convert_encoding_to_utf8(body, from)
      Encoding::Converter.new(from, 'utf-8').convert(body)
    rescue EncodingError
      body
    end
  end
end
