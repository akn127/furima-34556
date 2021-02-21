FactoryBot.define do
  factory :user do
    nickname              {Faker::Internet.name}
    email                 {Faker::Internet.free_email}
    password              {"abc123"}
    password_confirmation {password}
    family_name           {"田中"}
    first_name            {"二郎"}
    kana_family_name      {"タナカ"}
    kana_first_name       {"ジロウ"}
    birth_date            {"2000-01-01"}
  end
end