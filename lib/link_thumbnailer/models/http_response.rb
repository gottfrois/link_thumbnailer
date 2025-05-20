# frozen_string_literal: true

require 'link_thumbnailer/model'

module LinkThumbnailer
  module Models
    class HttpResponse < ::LinkThumbnailer::Model

      attr_reader :code, :headers, :body

      def initialize(http_response)
        @code = http_response.code
        @headers = http_response.header.to_hash
        @body = http_response.body
      end

      def content_type
        (headers['content-type'] || @headers['Content-Type'])&.first
      end

      def image?
        content_type.to_s.match?(/^image\//)
      end
      
      def html?
        content_type.to_s.match?(/^(text|application)\/html/)
      end

    end
  end
end
