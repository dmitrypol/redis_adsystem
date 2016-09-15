class ClickController < ApplicationController
  def index
    #click_params = request.params.except(:controller, :action)
    ProcessClickJob.perform_later({ad_id: request.params[:ad_id]})
    # => grab url param for redirect
    redirect_url = Base64.decode64(request.params[:url])
    redirect_to redirect_url
    #render status: 200
  end
end
