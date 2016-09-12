class Click < ApplicationRecord
  belongs_to :ad
	#validates :ad, :ip, :user_agent, :url, :time, presence: true
end
