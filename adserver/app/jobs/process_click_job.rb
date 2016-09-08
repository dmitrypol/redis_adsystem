class ProcessClickJob < ApplicationJob
  queue_as :click

  def perform(*args)
    # Do something later
  end
end
