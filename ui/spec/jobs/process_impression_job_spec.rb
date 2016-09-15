require 'rails_helper'

RSpec.describe ProcessImpressionJob, type: :job do
  it 'valid' do
    ad = create(:ad)
    date_hour = Time.now.strftime("%Y%m%d:%H")
    key = [ad.id, date_hour].join(':')
    REDIS_IMPR.incrby(key, 10)
    ProcessImpressionJob.perform_later
    expect(ad.reload.impressions.count).to eq 1
    expect(ad.impressions.first.counter).to eq 10
  end
  it 'no impressions in Redis' do
    ProcessImpressionJob.perform_later
    expect(Impression.count).to eq 0
  end
  it 'invalid impression key in Redis' do
    REDIS_IMPR.incr 'invalid_key'
    ProcessImpressionJob.perform_later
    expect(Impression.count).to eq 0
  end
end
