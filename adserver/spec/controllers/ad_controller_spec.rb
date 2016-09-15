require 'rails_helper'

RSpec.describe AdController, type: :controller do

  after(:each) do
    expect(response).to have_http_status(:success)
  end

  it 'with ads' do
    ads = [{:ad_id=>2, :title=>"title 2", :body=>"body 2", :cpc=>2, :link=>"http://website2.com"}, {:ad_id=>1, :title=>"title 1", :body=>"body 1", :cpc=>1, :link=>"http://website1.com"}]
    GetAds.stub_chain(:new, :perform).and_return(ads)
    params = {kw: @key}
    get :index, params: params
    expect(response.body).to include 'title 1'
    expect(response.body).to include 'title 2'
  end

  it 'invalid keyword' do
    GetAds.stub_chain(:new, :perform).and_return([])
    params = {kw: 'invalid'}
    get :index, params: params
    expect(response.body).to eq '[]'
  end

  it 'nil keyword' do
    GetAds.stub_chain(:new, :perform).and_return([])
    params = {kw: nil}
    get :index, params: params
    expect(response.body).to eq '[]'
  end

end
