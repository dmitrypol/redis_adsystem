class Ad < ApplicationRecord
  validates :keywords, :cpc, :budget, :title, :body, :link, presence: true

  before_save do
    keywords.split(',').each do |kw|
      # => remove ad
      REDIS_ADS.srem  kw, ad_content
    end
  end

  after_save do
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

  def redirect_url
    query = { url: Base64.encode64(link) }.to_query
    "http://localhost:3000/click?#{query}"
  end

  def ad_content
    # => encode link into redirect URL
    output = {title: title, body: body, cpc: cpc, link: redirect_url}
    return output.to_json
  end

end
