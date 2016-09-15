require 'rails_helper'

RSpec.describe GetAds, type: :service do

  before(:each) do
    @key = 'keyword1'
    member1 = {ad_id: 1, title: 'title 1', body: 'body 1', cpc: 1, link: 'http://website1.com'}.to_json
    member2 = {ad_id: 2, title: 'title 2', body: 'body 2', cpc: 2, link: 'http://website2.com'}.to_json
    REDIS_ADS.sadd @key, member1
    REDIS_ADS.sadd @key, member2
    @ads = REDIS_ADS.smembers @key
  end

  context 'perform' do
    it 'valid keyword' do
      expect(GetAds.new(keyword: @key).perform).to eq @ads
    end
    it 'invalid keyword' do
      expect(GetAds.new(keyword: 'invalid').perform).to eq []
    end
    it 'nil keyword' do
      expect(GetAds.new(keyword: nil).perform).to eq []
    end
  end

  context 'record_impressions' do
    it 'valid' do
      date_hour = Time.now.strftime("%Y%m%d:%H")
      keys = ["2:#{date_hour}", "1:#{date_hour}"]
      GetAds.new(keyword: @key).perform
      expect(REDIS_IMPR.keys).to eq keys
    end
    it 'invalid' do
      GetAds.new(keyword: 'invalid').perform
      expect(REDIS_IMPR.keys).to eq []
    end
  end

  context 'record_keyword' do
    it 'valid' do
      GetAds.new(keyword: @key).perform
      expect(REDIS_KW.keys).to eq [@key]
      expect(REDIS_KW.get(@key)).to eq '1'
    end
    it 'invalid' do
      GetAds.new(keyword: 'invalid').perform
      expect(REDIS_KW.keys).to eq ['invalid']
      expect(REDIS_KW.get('invalid')).to eq '1'
    end
  end

end
