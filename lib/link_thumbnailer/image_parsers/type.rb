module LinkThumbnailer
  module ImageParsers
    class Type < ::LinkThumbnailer::ImageParsers::Base

      def call
        ::FastImage.type(image.src, raise_on_failure: true)
      rescue ::FastImage::ImageFetchFailure
        :jpg
      end

    end
  end
end
