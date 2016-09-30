class Impression < ApplicationRecord
  belongs_to :ad
  validates :ad, presence: true

  def name
    ad.try(:name)
  end

end
