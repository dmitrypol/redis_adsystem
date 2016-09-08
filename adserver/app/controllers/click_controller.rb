class ClickController < ApplicationController
  def index
    click_params = request.params.except(:controller, :action)
    ProcessClickJob.perform_later(click_params)
    render status: 200
  end
end
