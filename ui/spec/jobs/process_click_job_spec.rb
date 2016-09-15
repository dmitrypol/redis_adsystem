require 'rails_helper'

RSpec.describe ProcessClickJob, type: :job do
  it 'valid' do
    ad = create(:ad)
    ProcessClickJob.perform_later(ad_id: ad.id)
    expect(ad.reload.clicks.count).to eq 1
    expect(ad.budget).to eq 9
  end
  it 'invalid ad_id' do
    ProcessClickJob.perform_later(ad_id: 1000)
    expect(Click.count).to eq 0
  end
  it 'missing ad_id' do
    ProcessClickJob.perform_later(ad_id: nil)
    expect(Click.count).to eq 0
  end
end
