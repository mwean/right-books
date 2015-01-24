FactoryGirl.define do
  factory :comment do
    user
    book
    body { Faker::Lorem.sentence }
  end
end
