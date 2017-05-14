class Category < ApplicationRecord

  has_many :types, dependent: :destroy

  accepts_nested_attributes_for :types, allow_destroy: true,
    reject_if: proc { |attributes| attributes[:name].blank? }

  scope :recent, ->{order created_at: :desc}

  validates :name, presence: true, length: {maximum: 255, minimum: 2}
end
