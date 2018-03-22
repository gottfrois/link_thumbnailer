# frozen_string_literal: true

require 'link_thumbnailer/model'

module LinkThumbnailer
  module Models
    class Favicon < ::LinkThumbnailer::Model

      attr_reader :uri

      def initialize(uri)
        @uri = uri
      end

      def to_s
        uri.to_s
      end

      def as_json(*)
        {
          src: to_s
        }
      end

    end
  end
end
