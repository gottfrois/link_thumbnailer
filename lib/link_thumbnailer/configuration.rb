require 'hashie'

module LinkThumbnailer
	class Configuration < Hashie::Mash

    def rmagick_attributes
      LinkThumbnailer.logger.info "[DEPRECATION] rmagick_attributes is deprecated. Use image_attributes instead."
      image_attributes
    end

    def rmagick_attributes=(value)
      LinkThumbnailer.logger.info "[DEPRECATION] rmagick_attributes is deprecated. Use image_attributes instead."
      self.image_attributes = value
    end

	end
end
