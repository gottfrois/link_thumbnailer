require 'link_thumbnailer/model'
require 'link_thumbnailer/video_parser'

module LinkThumbnailer
  module Models
    class Video < ::LinkThumbnailer::Model

      attr_reader :src, :size, :duration, :provider, :id, :embed_code

      def initialize(src)
        @src        = src
        @id         = parser.id
        @size       = parser.size
        @duration   = parser.duration
        @provider   = parser.provider
        @embed_code = parser.embed_code
      end

      def to_s
        src.to_s
      end

      def as_json(*)
        {
          id:         id,
          src:        src.to_s,
          size:       size,
          duration:   duration,
          provider:   provider,
          embed_code: embed_code
        }
      end

      private

      def parser
        @parser ||= ::LinkThumbnailer::VideoParser.new(self)
      end

    end
  end
end
