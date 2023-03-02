class Follow < ApplicationRecord
  belongs_to :user, class_name: "User", foreign_key: :user_id
  belongs_to :followed, class_name: "User", foreign_key: :followed_id
  
  validates :user, uniqueness: {scope: :followed},presence: true
  validate :followed_is_not_user_it_self

  def followed_is_not_user_it_self
    self.errors.add :follow, 'Cant follow yourself' if self.user==self.followed
  end
end
