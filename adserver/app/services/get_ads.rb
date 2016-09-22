class GetAds

  def initialize(keyword:)
    @keyword = keyword
  end

  def perform
    @ads = REDIS_ADS.smembers @keyword
    record_impressions
    record_keyword
    return @ads
  end

private

  # keep track of number of impressions for each by hour.  Data gets moved into main DB
  def record_impressions
    # => current date and hour
    date_hour = Time.now.strftime("%Y%m%d:%H")
    @ads.each do |ad|
      # => grab ad_id from each JSON
      ad2 = JSON.parse(ad)
      ad_id = ad2['ad_id']
      key = [ad_id, date_hour].join(':')
      REDIS_IMPR.incr key
    end
  end

  # keep track which keywords get requested at least once a week, data remains in Redis
  def record_keyword
    REDIS_KW.pipelined do
      REDIS_KW.incr @keyword
      REDIS_KW.expire @keyword, 1.week.to_i
    end
  end

end
