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

  scope :unpaid, -> {
    where(status: 'unpaid')
  }
  scope :paid, -> {
    where(status: 'paid')
  }
  scope :sent, -> {
    where(status: 'sent')
  }
  scope :newest, -> { order(order_time: :desc) }

  def as_json(options=nil,user=nil)
    super({ only: [:id,:shipping_address,:shipping_address_notes,:recipient_name,:recipient_contact, :total, :order_time, :status] }.merge(options || {}))
  end

  def self.order_attr
    {include: 
      [
        {order_details:OrderDetail.order_detail_attr},
      ]
    }
  end
  
  def self.generate_id(now)
    "ord_"+("#{now}+#{self.count+1}").to_i.to_s(16).to_s.rjust(12, '0')
  end
end
