class ProcessImpressionJob < ApplicationJob
  queue_as :low

  def perform
    REDIS_IMPR.keys.each do |key|
      # split 459:20160914:17  adid:date:hour
      key2 = key.split(':')
      ad_id = key2[0]
      date = key2[1]
      hour = key2[2]
      # => create impression record in main DB
      Impression.where(ad_id: ad_id, date: date, hour: hour).first_or_create!
      # => delete the key
      REDIS_IMPR.del(key)
    end
  end
end
