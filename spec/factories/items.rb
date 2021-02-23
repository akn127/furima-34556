FactoryBot.define do
  factory :item do
    item_name           {"スニーカー"}
    item_text           {"限定物のスニーカーです"}
    category_id         {3}
    status_id           {2}
    deliveryfee_id      {3}
    area_id             {14}
    days_id             {2}
    price               {3000}

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.jpg'), filename: 'test_image.jpg')
    end
  end
end
