module LinkThumbnailer
  module Generators
    class InstallGenerator < Rails::Generators::Base

      source_root File.expand_path('../../templates', __FILE__)

      desc 'Creates a LinkThumbnailer initializer for your application.'

      def install
        route "use_link_thumbnailer"
      end

      def copy_initializer
        template 'initializer.rb', 'config/initializers/link_thumbnailer.rb'
      end

    end
  end
end
