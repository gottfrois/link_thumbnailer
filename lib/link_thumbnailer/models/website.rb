module LinkThumbnailer
  module Models
    class Website

      HEADINGS = [:h1, :h2, :h3, :h4, :h5, :h6]

      attr_accessor :images, :elements

      def initialize
        self.images   = []
        self.elements = []
      end

      def add_image(image)
        image.valid? ? images.push(image) : false
      end

      def add_element(element)
        elements.push(element)
      end

      def headings
        @headinds ||= elements.select { |e| HEADINGS.include?(e.tag) }
      end

      def paragraphs
        @paragraphs ||= elements.select { |e| e.tag == :p }
      end

    end
  end
end
