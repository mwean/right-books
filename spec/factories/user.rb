FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "#{n}#{Faker::Internet.email}" }
    name { Faker::Name.name }
    password { Faker::Internet.password }
    password_confirmation { password }
  end
end
