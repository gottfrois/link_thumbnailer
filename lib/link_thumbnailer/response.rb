module LinkThumbnailer
  class Response
    def initialize(response)
      @response = response
      @config = ::LinkThumbnailer.page.config
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
      body = @response.body
      body = convert_encoding(body, charset, @config.encoding) if charset != '' && charset != @config.encoding
      body
    end

    def convert_encoding(body, from, to)
      Encoding::Converter.new(from, to).convert(body)
    rescue EncodingError
      body
    end
  end
end
