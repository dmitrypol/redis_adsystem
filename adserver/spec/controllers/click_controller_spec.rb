require 'rails_helper'

RSpec.describe ClickController, type: :controller do

  before(:each) do
    # => http://localhost:3000/click?ad_id=51&url=aHR0cDovL3dlYnNpdGUwLmNvbQ
    @link = 'http://website1.com'
    query = { ad_id: 1, url: Base64.encode64(@link) }.to_query
    @redirect_url = "http://test.host/click?#{query}"
    # =>
    @key = 'keyword1'
    member1 = {ad_id: 1, title: 'title 1', body: 'body 1', cpc: 1, link: @redirect_url}.to_json
    member2 = {ad_id: 2, title: 'title 2', body: 'body 2', cpc: 2, link: @redirect_url}.to_json
    REDIS_ADS.sadd @key, member1
    REDIS_ADS.sadd @key, member2
  end

  after(:each) do
    expect(response).to have_http_status(:found)  # => 302
  end

  it 'valid' do
    params = {ad_id: 1, url: @redirect_url}
    expect {get :index, params: params}.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
    #expect(response).to redirect_to @link
  end

end
