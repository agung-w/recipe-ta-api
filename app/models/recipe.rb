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

  def as_json(options=nil)
    super({ only: [:id,:title, :poster_pic_url, :serving, :prep_time,:description, :created_at] }.merge(options || {}))
  end

  def self.recipe_attr
    {include: 
      [
        {user:User.profile_attr},
        {tags:Tag.tag_attr}
      ]
    }
  end

  def self.recipe_detail_attr
    {include: 
      [
        {user:User.profile_attr},
        {recipe_ingredients:RecipeIngredient.recipe_ingredient_attr},
        {cooking_steps:CookingStep.cooking_steps_attr},
        {tags:Tag.tag_attr}
      ]
    }
  end
end
