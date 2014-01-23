require 'delegate'

module LinkThumbnailer
  class ImageValidator < ::SimpleDelegator

    attr_reader :config, :image

    def initialize(image)
      @config = ::LinkThumbnailer.config
      @image  = image
    end

    def call
      blacklist_url.each do |url|
        return false if image.src && image.src.to_s[url]
      end

      true
    end

    private

    def blacklist_url
      config.blacklist_url
    end

  end
end
