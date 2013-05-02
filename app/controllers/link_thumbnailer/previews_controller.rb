module LinkThumbnailer
  class PreviewsController < ApplicationController

    respond_to :json

    def create
      @preview = LinkThumbnailer.generate(params[:url])
      respond_with @preview
    end
  end
end
