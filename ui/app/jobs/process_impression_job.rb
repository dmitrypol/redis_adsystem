class ProcessImpressionJob < ApplicationJob
  queue_as :low

  def perform
    REDIS_IMPR.keys.each do |key|
      begin
        counter = REDIS_IMPR.get(key)
        # split 459:20160914:17  ad_id:date:hour
        key2 = key.split(':')
        ad_id = key2[0]
        date = key2[1]
        hour = key2[2]
        # =>
        ad = Ad.find(ad_id)
        # => create impression record in main DB
        ad.impressions.create(date: date, hour: hour, counter: counter)
        # => delete the key
        REDIS_IMPR.del(key)
      rescue Exception => e
      end
    end
  end
end
