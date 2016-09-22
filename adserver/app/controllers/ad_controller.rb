class AdController < ApplicationController
  def index
    ad_params = request.params.except(:controller, :action)
    ads = GetAds.new(keyword: ad_params[:kw]).perform
    render json: ads
  end
end
