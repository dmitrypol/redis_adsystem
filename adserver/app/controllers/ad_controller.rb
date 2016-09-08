class AdController < ApplicationController
  def index
    ad_params = request.params.except(:controller, :action)
    ads = REDIS_ADS.smembers ad_params[:kw]
    if ads
      render json: ads
    else
      render status: 200
    end
  end
end
