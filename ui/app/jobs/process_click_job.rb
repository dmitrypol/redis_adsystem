class ProcessClickJob < ApplicationJob
  queue_as :click

  def perform(*args)
    # decrement budget
    Ad.find(args[:adid].to_i).decrement_budget
    # record the click
    Click.create!(ad: args[:adid].to_i)
  end
end
