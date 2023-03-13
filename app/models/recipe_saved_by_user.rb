class RecipeSavedByUser < ApplicationRecord
  self.primary_key = :user_id,:recipe_id
  belongs_to :user
  belongs_to :recipe
  validates :user, uniqueness: {scope: :recipe},presence: true
end
