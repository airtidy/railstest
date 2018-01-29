FactoryBot.define do
  factory :ranking do
    association :nesoberi
    association :user
    rank 1
  end
end
