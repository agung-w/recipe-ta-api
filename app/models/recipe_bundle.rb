class RecipeBundle < ApplicationRecord
  belongs_to :recipe
  validates :description, presence: true
  validates :title, presence: true
  validates :price, :numericality => { :greater_than_or_equal_to => 0 }
  validates :stock, :numericality => { :greater_than_or_equal_to => 0 }

  def self.recipe_bundle_attr
    {only:[:title,:description]}
  end
  def self.recipe_bundle_attr_detail
    {only:[:title,:description,:price]}
  end
end
