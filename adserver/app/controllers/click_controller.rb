class ClickController < ApplicationController
  def index
    click_params = request.params.except(:controller, :action)
    ProcessClickJob.perform_later(click_params)
    # => grab url param for redirect
    redirect_url = Base64.decode64(click_params[:url])
    redirect_to redirect_url
    #render status: 200
  end
end
