require 'video_info'

module LinkThumbnailer
  class VideoParser

    attr_reader :parser

    def initialize(video)
      @parser = ::VideoInfo.new(video.src.to_s)
    rescue ::VideoInfo::UrlError
      @parser = nil
    end

    def id
      parser.video_id
    rescue NoMethodError
      nil
    end

    def size
      [parser.width, parser.height]
    rescue NoMethodError
      []
    end

    def duration
      parser.duration
    rescue NoMethodError
      nil
    end

    def provider
      parser.provider
    rescue NoMethodError
      nil
    end

    def embed_code
      parser.embed_code
    rescue NoMethodError
      nil
    end

  end
end
