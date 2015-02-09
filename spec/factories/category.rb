FactoryGirl.define do
  factory :category do
    key { HomesController::FEATURED_CATEGORY_KEYS.sample }
    name { key.titleize }
  end
end
