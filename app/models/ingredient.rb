class Ingredient < ApplicationRecord
  validates :name, length: { maximum: 250 },presence: true
  before_save { |ingredient| ingredient.name = ingredient.name.downcase }
  def self.ingredient_attr
    {only:[:id,:name,:pic_url]}
  end
end
