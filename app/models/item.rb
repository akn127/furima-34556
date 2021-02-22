class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  belongs_to :status
  belongs_to :deliveryfee
  belongs_to :area
  belongs_to :days

  with_options presence: true do
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

  has_one_attached :image
end
