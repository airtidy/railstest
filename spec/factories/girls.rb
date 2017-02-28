FactoryGirl.define do
  factory :girl do
    name { Faker::Name.name }
    age { Faker::Number.between(15, 18) }
  end
end
