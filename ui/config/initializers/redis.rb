schedule_array =
[
  {'name' => 'ProcessImpressionJob',
    'class' => 'ProcessImpressionJob',
    'cron'  => '1 * * * *',
    'queue' => 'low',
    'active_job' => true },
]

Sidekiq.configure_server do |config|
  config.redis = { host: Rails.application.config.redis_host, post: 6379, db: 0, namespace: 'sidekiq' }
  Sidekiq::Cron::Job.load_from_array! schedule_array
end

Sidekiq.configure_client do |config|
  config.redis = { host: Rails.application.config.redis_host, post: 6379, db: 0, namespace: 'sidekiq' }
end

if Rails.env.test?
	REDIS_ADS =  Redis::Namespace.new('ads', redis: MockRedis.new )
  REDIS_IMPR = Redis::Namespace.new('impr', redis: MockRedis.new )
  REDIS_KW =   Redis::Namespace.new('kw', redis: MockRedis.new )
  REDIS_CODE_COV =  Redis::Namespace.new('codecov', redis: MockRedis.new)
else
  redis_conn = Redis.new(host: Rails.application.config.redis_host, port: 6379, db: 0, driver: :hiredis)
  REDIS_ADS =  Redis::Namespace.new('ads', redis: redis_conn)
  REDIS_IMPR = Redis::Namespace.new('impr', redis: redis_conn)
  REDIS_KW   = Redis::Namespace.new('kw',  redis: redis_conn)
  REDIS_CODE_COV =  Redis::Namespace.new('codecov', redis: redis_conn)
end
