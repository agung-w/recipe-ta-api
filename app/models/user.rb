class User < ApplicationRecord
  has_secure_password
  validates :name, length: { in: 3..60 }, format: { with: /\A[a-zA-Z ]+\z/,message: "only allows letters" }
  validates :email, email:true ,uniqueness: true
  validates :password, length: {in: 6..60}
  validates :username,length: { in: 3..60 }, uniqueness: true,format: { with: /\A[a-zA-Z0-9_-]+\z/,message: "only allows letters, numbers, - and _" }

  def as_json
    {
      username: username,
      name: name,
      profile_pic_url: profile_pic_url,
      followers_count: followers_count,
      following_count: following_count
    }
  end

  def self.generate_default_username
    "user_"+(self.count+1).to_s.rjust(8, '0')
  end
end
