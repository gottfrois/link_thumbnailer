module LinkThumbnailer
  class PreviewsController < ApplicationController

    respond_to :json

    def create
      @preview = LinkThumbnailer.generate(params[:url])
      render json: @preview.to_json
    end
  end
end
