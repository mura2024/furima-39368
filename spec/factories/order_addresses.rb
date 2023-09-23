FactoryBot.define do
  factory :order_address do
    post_code     { '123-4567' }
    prefecture_id { 3 }
    city          { Faker::Address.city }
    house_number  { Faker::Address.street_address }
    building      { Faker::Lorem.sentence }
    phone_number  { '09012341234' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
