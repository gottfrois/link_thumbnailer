require 'link_thumbnailer/model'

module LinkThumbnailer
  module Models
    class Website < ::LinkThumbnailer::Model

      attr_accessor :url, :title, :description, :images

      def initialize
        @images = []
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
          title:        title,
          description:  description,
          images:       images
        }
      end

    end
  end
end
