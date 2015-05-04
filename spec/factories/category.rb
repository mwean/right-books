FactoryGirl.define do
  factory :category do
    key { HomesController::FEATURED_CATEGORY_KEYS.sample }
    name { key.titleize }

    trait :with_description do
      description { Faker::Lorem.paragraph }
    end

    trait :with_image do
      image_url 'http://lorempixel.com/output/city-q-c-100-100-5.jpg'
    end
  end
end
