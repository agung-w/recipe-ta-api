class RecipeTag < ApplicationRecord
  belongs_to :recipe
  belongs_to :tag
  validates :recipe, uniqueness: {scope: :tag},presence: true

end
