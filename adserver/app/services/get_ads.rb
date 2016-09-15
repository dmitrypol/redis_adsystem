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
    timestamp = Time.now.hour
    @ads.each do |ad|
      #Rails.logger.info ad[:adid]    TODO
      # => grab adid from each JSON
      adid = ''
      key = [adid, timestamp].join(':')
      REDIS_IMPR.incr key
    end
  end

end
