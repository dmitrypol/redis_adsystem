class GetAds

  def initialize(keyword:)
    @keyword = keyword
  end

  def perform
    @ads = REDIS_ADS.smembers @keyword
    record_impressions
    return @ads
  end

private

  def record_impressions
    # => current date and hour
    date_hour = Time.now.strftime("%Y%m%d:%H")
    @ads.each do |ad|
      # => grab adid from each JSON
      ad2 = JSON.parse(ad)
      adid = ad2['adid']
      key = [adid, date_hour].join(':')
      REDIS_IMPR.incr key
    end
  end

end
