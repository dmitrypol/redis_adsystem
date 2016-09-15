class ProcessClickJob < ApplicationJob
  queue_as :click

  def perform(ad_id:)
    # queue the job for processing
  end
end
