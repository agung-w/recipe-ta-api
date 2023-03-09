class Metric < ApplicationRecord
  validates :name, length: { maximum: 100 }, presence: true
  validates :abbrev, length: { maximum: 6 }, presence: true
  validates :volume, numericality: true, allow_nil: true
  validates :weight, numericality: true, allow_nil: true

  def self.metric_attr
    {only:[:id,:name,:abbrev]}
  end
end
