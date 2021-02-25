class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  belongs_to :status
  belongs_to :deliveryfee
  belongs_to :area
  belongs_to :days
  has_one_attached :image
  has_one :order


  with_options presence: true do
    validates :image
    validates :item_name
    validates :item_text
    validates :category_id
    validates :status_id
    validates :deliveryfee_id
    validates :area_id
    validates :days_id
    validates :price
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :status_id
    validates :deliveryfee_id
    validates :area_id
    validates :days_id
  end

  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :price, numericality: { with: /\A[0-9]+\z/, message: 'Half-width numbers' }
end
