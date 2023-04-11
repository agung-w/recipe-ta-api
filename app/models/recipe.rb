class Recipe < ApplicationRecord
  belongs_to :user

  validates :title, length: { maximum: 100 },presence: true
  validates :description, length: { maximum: 1000 },presence: true
  validates :prep_time, numericality: true, allow_nil: true
  validates :serving, numericality: true, allow_nil: true

  has_many :cooking_steps
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :recipe_tags
  has_many :tags, through: :recipe_tags
  has_many :recipe_saved_by_user

  accepts_nested_attributes_for :recipe_ingredients,:cooking_steps,:recipe_tags

  scope :published, -> {
    where(is_published: true)
  }

  scope :draft, -> {
    where(is_published: [false, nil])
  }

  scope :rejected, -> {
    where(is_published: false)
  }

  scope :pending, -> {
    where(is_published: nil)
  }

  def as_json(options=nil,user=nil)
    super({ only: [:id,:title, :poster_pic_url, :serving, :prep_time,:description,:is_published , :created_at] }.merge(options || {})).merge(is_saved:is_saved(user))
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
        {tags:Tag.tag_attr},
      ]
    }
  end

  def is_saved(user)
    RecipeSavedByUser.find_by(user:user,recipe:self.id) ? true : nil
  end
end
