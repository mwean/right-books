FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "#{n}#{Faker::Internet.email}" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { Faker::Internet.password }
    password_confirmation { password }
    admin false

    trait(:admin) do
      admin true
    end
  end
end
