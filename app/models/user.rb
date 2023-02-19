class User < ApplicationRecord
    validates :name, length: { in: 3..60 }, format: { with: /\A[a-zA-Z]+\z/,message: "only allows letters" }
    validates :email, email:true
end
