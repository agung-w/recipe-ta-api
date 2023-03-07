class Ingredient < ApplicationRecord
  validates :name, length: { maximum: 250 },presence: true
  before_save { |ingredient| ingredient.name = ingredient.name.downcase }
end
