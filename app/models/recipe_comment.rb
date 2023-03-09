class RecipeComment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  validates :content, length: { in: 1..3000 }

end
