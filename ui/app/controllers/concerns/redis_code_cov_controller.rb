module RedisCodeCovController
  extend ActiveSupport::Concern

  included do
    before_action :redis_code_cov
  end

  def redis_code_cov
    key = [self.class.name, params[:action]].join('.')
    REDIS_CODE_COV.incr key
  end

end
