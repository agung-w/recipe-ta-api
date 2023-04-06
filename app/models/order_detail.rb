class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :recipe_bundle

  validates :quantity, :numericality => { :greater_than_or_equal_to => 0 }
  validates :price, :numericality => { :greater_than_or_equal_to => 0 }
  validates :total_price, :numericality => { :greater_than_or_equal_to => 0 }
end
