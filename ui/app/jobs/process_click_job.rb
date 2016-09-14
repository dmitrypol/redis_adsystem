class ProcessClickJob < ApplicationJob
  queue_as :click

  def perform(*args)
    adid = self.arguments.first['adid'].to_i
    # record the click
    Click.create!(ad_id: adid)
    # decrement ad budget
    ad = Ad.find(adid)
    ad.update(budget: ad.budget - ad.cpc)
  end
end
