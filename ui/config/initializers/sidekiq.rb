Sidekiq.configure_server do |config|
  config.redis = { host: Rails.application.config.redis_host, post: 6379, db: 0, namespace: 'sidekiq' }
end

Sidekiq.configure_client do |config|
  config.redis = { host: Rails.application.config.redis_host, post: 6379, db: 0, namespace: 'sidekiq' }
end
