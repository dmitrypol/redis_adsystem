require 'rails_helper'

RSpec.describe Ad, type: :model do

  context 'update_ads_cache' do
    it 'with budget' do
      create(:ad, keywords: 'keyword1,keyword2', title: 'title 1')
      create(:ad, keywords: 'keyword2,keyword3', title: 'title 2')
      expect(REDIS_ADS.keys.count).to eq 3
      expect(REDIS_ADS.keys.first).to eq  'keyword1'
      expect(REDIS_ADS.keys.second).to eq 'keyword2'
      expect(REDIS_ADS.keys.third).to eq  'keyword3'
      expect(REDIS_ADS.smembers('keyword1').first).to  include 'title 1'
      expect(REDIS_ADS.smembers('keyword2').second).to include 'title 1'
      expect(REDIS_ADS.smembers('keyword2').first).to  include 'title 2'
      expect(REDIS_ADS.smembers('keyword3').first).to  include 'title 2'
    end
    it 'no budget' do
      create(:ad, budget: 0)
      expect(REDIS_ADS.keys.count).to eq 0
    end
  end

  context 'ad_content' do
  end

  context 'redirect_url' do
  end

end
