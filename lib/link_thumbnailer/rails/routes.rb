require 'link_thumbnailer/rails/routes/mapping'
require 'link_thumbnailer/rails/routes/mapper'

module LinkThumbnailer
  module Rails
    class Routes

      module Helper
        def use_link_thumbnailer(options = {}, &block)
          LinkThumbnailer::Rails::Routes.new(self, &block).generate_routes!(options)
        end
      end

      def self.install!
        ActionDispatch::Routing::Mapper.send :include, LinkThumbnailer::Rails::Routes::Helper
      end

      attr_accessor :routes

      def initialize(routes, &options)
        @routes, @options = routes, options
      end

      def generate_routes!(options)
        @mapping = Mapper.new.map(&@options)
        routes.scope 'link', :as => 'link' do
          map_route(:previews, :preview_routes)
        end
      end

      private

      def map_route(name, method)
        unless @mapping.skipped?(name)
          send method, @mapping[name]
        end
      end

      def preview_routes(mapping)
        routes.scope :controller => mapping[:controllers] do
          routes.match 'preview', :via => :post, :action => :create, :as => mapping[:as], :defaults => { :format => 'json' }
        end
      end

    end
  end
end
