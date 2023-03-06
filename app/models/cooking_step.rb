class CookingStep < ApplicationRecord
  belongs_to :recipe
  validates :step, numericality:true, uniqueness: { scope: :recipe }
  validates :description, length: { maximum: 1000 },presence: true
  self.primary_keys = :step, :recipe_id

end
