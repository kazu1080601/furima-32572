FactoryBot.define do
  factory :order do
    faker_address = Gimei.address
    post_number     { Faker::Number.number(digits: 3).to_s + '-' + Faker::Number.number(digits: 4).to_s }
    area_id         { Faker::Number.between(from: 2, to: 48) }
    municipality    { faker_address.city.kanji }
    address         { faker_address.town.kanji }
    building        { Faker::Lorem.word }
    phone           { Faker::Number.leading_zero_number(digits: 11) }
    token           { Faker::Lorem.characters(number: 10) }
  end
end
