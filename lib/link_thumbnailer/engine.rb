module LinkThumbnailer
  class Engine < Rails::Engine

    initializer 'link_thumbnailer.routes' do
      LinkThumbnailer::Rails::Routes.install!
    end

  end
end
