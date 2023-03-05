class Recipe < ApplicationRecord
  belongs_to :user

  validates :title, length: { maximum: 100 },presence: true
  validates :description, length: { maximum: 1000 },presence: true
  validates :prep_time, numericality: true
  validates :serving, numericality: true
end
