# frozen_string_literal: true

require 'link_thumbnailer/model'

module LinkThumbnailer
  module Models
    class Website < ::LinkThumbnailer::Model

      attr_accessor :url, :title, :description, :images, :videos, :favicon

      def initialize
        @images = []
        @videos = []
      end

      def video=(video)
        self.videos = video
      end

      def videos=(videos)
        Array(videos).each do |video|
          @videos << video
        end
      end

      def image=(image)
        self.images = image
      end

      def images=(images)
        Array(images).each do |image|
          next unless image.valid?
          @images << image
        end
      end

      def images
        @images.sort!
      end

      def as_json(*)
        {
          url:          url.to_s,
          favicon:      favicon,
          title:        title,
          description:  description,
          images:       images.map(&:as_json),
          videos:       videos.map(&:as_json)
        }
      end

    end
  end
end
