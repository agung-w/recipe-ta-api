class Tag < ApplicationRecord
  validates :name, length: { maximum: 140 },presence: true
end
