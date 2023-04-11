class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details
  validates :shipping_address, presence: true
  validates :shipping_fee, :numericality => { :greater_than_or_equal_to => 0 }
  validates :payment_fee, :numericality => { :greater_than_or_equal_to => 0 }
  validates :order_total, :numericality => { :greater_than_or_equal_to => 0 }
  validates :total, :numericality => { :greater_than_or_equal_to => 0 }
  validates :status, presence: true
  validates :order_time, presence: true
  validates :recipient_name, presence: true
  validates :recipient_contact, numericality: true

  accepts_nested_attributes_for :order_details

  def self.generate_id(now)
    "ord_"+("#{now}+#{self.count+1}").to_i.to_s(16).to_s.rjust(12, '0')
  end
end
