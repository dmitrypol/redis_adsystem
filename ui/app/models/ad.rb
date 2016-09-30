class Ad < ApplicationRecord
  validates :keywords, :cpc, :budget, :title, :body, :link, presence: true

  has_many :clicks
  has_many :impressions

  after_save :update_ads_cache

  def name
    title
  end

private

  def update_ads_cache
    # => check if any important attributes changed
    return unless keywords_changed? or cpc_changed? or budget_changed? or title_changed? or body_changed? or link_changed?
    REDIS_ADS.pipelined do
      keywords.split(',').each do |kw|
        REDIS_ADS.srem  kw, ad_content  # => remove ad
        # => insert ad if there is budget
        REDIS_ADS.sadd  kw, ad_content if budget > 0
      end
    end
  end

  def ad_content
    # => encode link into redirect URL
    output = {ad_id: id, title: title, body: body, cpc: cpc, link: redirect_url}.to_json
    return output
  end

  def redirect_url
    query = { ad_id: id, url: Base64.encode64(link) }.to_query
    "http://localhost:3000/click?#{query}"
  end

end
