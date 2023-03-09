class Tag < ApplicationRecord
  validates :name, length: { maximum: 140 },presence: true,uniqueness:true

  def self.tag_attr
    {only:[:id,:name]}
  end

end
