require 'rails_helper'

RSpec.describe ProcessClickJob, type: :job do
  it 'valid' do
    expect {ProcessClickJob.perform_later(ad_id: 1)}.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end
end
