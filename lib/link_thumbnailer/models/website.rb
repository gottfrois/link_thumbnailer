module LinkThumbnailer
  module Models
    class Website

      attr_accessor :images, :title, :description

      def initialize
        @images = []
      end

      def images=(images)
        Array(images).each do |image|
          next unless image.valid?
          @images << image
        end
      end

      # def add_image(image)
      #   image.valid? ? images.push(image) : false
      # end

    end
  end
end
