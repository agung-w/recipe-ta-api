class Recipe < ApplicationRecord
  belongs_to :user

  validates :title, length: { maximum: 100 },presence: true
  validates :description, length: { maximum: 1000 },presence: true
  validates :prep_time, numericality: true
  validates :serving, numericality: true

  has_many :cooking_steps
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :recipe_tags
  has_many :tags, through: :recipe_tags

  accepts_nested_attributes_for :recipe_ingredients,:cooking_steps,:recipe_tags
end
