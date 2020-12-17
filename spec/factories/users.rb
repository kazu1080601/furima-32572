FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.free_email }
    password              { Faker::Internet.password(min_length: 6) + '1' + 'a' }
    password_confirmation { password }
    gimei = Gimei.name
    first_name_kanji      { gimei.first.kanji }
    last_name_kanji       { gimei.last.kanji }
    first_name_kana       { gimei.first.katakana }
    last_name_kana        { gimei.last.katakana }
    birthday              { Faker::Date.birthday(min_age: 18, max_age: 60) }
  end
end
