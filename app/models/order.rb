class Order < ApplicationRecord
  belongs_to :user
  validates :shipping_address, presence: true
  validates :shipping_fee, :numericality => { :greater_than_or_equal_to => 0 }
  validates :payment_fee, :numericality => { :greater_than_or_equal_to => 0 }
  validates :order_total, :numericality => { :greater_than_or_equal_to => 0 }
  validates :total, :numericality => { :greater_than_or_equal_to => 0 }
  validates :status, presence: true
  validates :order_time, presence: true
  validates :recipient_name, presence: true
  validates :recipient_contact, numericality: true
end
