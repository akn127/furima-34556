class Item < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :item_name
    validates :item_text
    validates :category_id
    validates :status_id
    validates :delivery_fee_id
    validates :area_id
    validates :days_id
    validates :price
  end
end
