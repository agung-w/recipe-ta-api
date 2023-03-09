class RecipeSavedByUser < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  validates :user, uniqueness: {scope: :recipe},presence: true
end
