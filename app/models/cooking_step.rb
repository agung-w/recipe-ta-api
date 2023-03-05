class CookingStep < ApplicationRecord
  belongs_to :recipe
  validates :description, length: { maximum: 1000 },presence: true
end
