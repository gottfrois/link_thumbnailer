module LinkThumbnailer
  class Railtie < ::Rails::Railtie

    initializer 'link_thumbnailer.routes' do
      LinkThumbnailer::Rails::Routes.install!
    end

  end
end
