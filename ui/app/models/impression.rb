class Impression < ApplicationRecord
  belongs_to :ad
  validates :ad, presence: true

end
