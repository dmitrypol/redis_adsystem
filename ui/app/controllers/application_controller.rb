class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include Clearance::Controller
  #before_action :require_login

  include Pundit
  rescue_from Pundit::NotAuthorizedError, Pundit::NotDefinedError do |exception|
    redirect_to main_app.root_path, alert: exception.message
  end

  before_action :redis_code_cov

private

  def redis_code_cov
    key = [self.class.name, params[:action]].join('.')
    REDIS_CODE_COV.incr key
  end

end
