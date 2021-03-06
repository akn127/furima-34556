FactoryBot.define do
  factory :order_delivery do
    postal_code { '123-4567' }
    area_id { 21 }
    municipality { "上田市" }
    address { "別府温泉1-2-3" }
    building_name { "山田ハイツ101" }
    phone_number { "09012345678" }
    token { "tok_abcdefghijk00000000000000000" }
  end
end