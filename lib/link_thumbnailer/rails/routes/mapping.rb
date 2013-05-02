module LinkThumbnailer
  module Rails
    class Routes
      class Mapping

        attr_accessor :controllers, :as, :skips

        def initialize
          @controllers = {
            previews: 'link_thumbnailer/previews'
          }

          @as = {
            previews: :preview
          }

          @skips = []
        end

        def [](routes)
          {
            controllers:  @controllers[routes],
            as:           @as[routes]
          }
        end

        def skipped?(controller)
          @skips.include?(controller)
        end
      end
    end
  end
end
