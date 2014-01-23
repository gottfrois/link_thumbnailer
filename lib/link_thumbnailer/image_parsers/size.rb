module LinkThumbnailer
  module ImageParsers
    class Size < ::LinkThumbnailer::ImageParsers::Base

      def call
        ::FastImage.size(image.src, raise_on_failure: true)
      rescue ::FastImage::ImageFetchFailure
        [0, 0]
      end

    end
  end
end
