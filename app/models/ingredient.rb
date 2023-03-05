class Ingredient < ApplicationRecord
  validates :name, length: { maximum: 250 },presence: true
end
