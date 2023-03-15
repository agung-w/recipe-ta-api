class RecipeComment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  validates :content, length: { in: 1..3000 }

  def as_json(options=nil)
    super({ only: [:content,:updated_at],include: [{user:User.profile_attr}]}.merge(options || {}))
  end
end
