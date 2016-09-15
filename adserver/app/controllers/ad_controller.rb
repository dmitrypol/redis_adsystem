class AdController < ApplicationController
  def index
    ad_params = request.params.except(:controller, :action)
    ads = GetAds.new(keyword: ad_params[:kw]).perform
    if ads
      render json: ads
    else
      render status: 200
    end
  end
end
