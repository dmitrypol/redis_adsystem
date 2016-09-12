class ProcessClickJob < ApplicationJob
  queue_as :click

  def perform(*args)
    # queue the job for processing
  end
end
