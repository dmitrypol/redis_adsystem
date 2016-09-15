Sidekiq.configure_server do |config|
  config.redis = { host: Rails.application.config.redis_host, post: 6379, db: 0, namespace: 'sidekiq' }
end

Sidekiq.configure_client do |config|
  config.redis = { host: Rails.application.config.redis_host, post: 6379, db: 0, namespace: 'sidekiq' }
end

redis_conn = Redis.new(host: Rails.application.config.redis_host, port: 6379, db: 0, driver: :hiredis)
REDIS_ADS = Redis::Namespace.new('ads', redis: redis_conn)
REDIS_IMPR = Redis::Namespace.new('impr', redis: redis_conn)
