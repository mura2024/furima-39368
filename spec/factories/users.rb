FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    password              { 'abcd1234' }
    password_confirmation { password }
    familyname            { '山田' }
    firstname             { '太郎' }
    familyname_kana       { 'ヤマダ' }
    firstname_kana        { 'タロウ' }
    birthday              { Faker::Date.birthday }
  end
end
