class ProcessClickJob < ApplicationJob
  queue_as :click

  def perform(*args)
    ad_id = args.first[:ad_id].to_i
    ad = Ad.find(ad_id)
    # decrement ad budget
    ad.update(budget: ad.budget - ad.cpc)
    # record the click
    ad.clicks.create
  rescue Exception => e
  end
end
