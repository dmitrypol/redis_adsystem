class Ad < ApplicationRecord
  validates :keywords, :cpc, :budget, :title, :body, :link, presence: true

  has_many :clicks

  before_save :remove_ads
  after_save :update_ads

private

  def remove_ads
    keywords.split(',').each do |kw|
      # => remove ad
      REDIS_ADS.srem  kw, ad_content
    end
  end

  def update_ads
    keywords.split(',').each do |kw|
      if budget > 0
        # => update ad
        REDIS_ADS.sadd kw, ad_content
      else
        # => remove ad
        REDIS_ADS.srem  kw, ad_content
      end
    end
  end

  def ad_content
    # => encode link into redirect URL
    output = {adid: id, title: title, body: body, cpc: cpc, link: redirect_url}.to_json
    return output
  end

  def redirect_url
    query = { adid: id, url: Base64.encode64(link) }.to_query
    "http://localhost:3000/click?#{query}"
  end

end
