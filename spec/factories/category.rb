FactoryGirl.define do
  factory :category do
    NAMES = [
      'History',
      'Biography & Memoir',
      'Political Philosophy',
      'Economics',
      'Culture'
    ]

    name { NAMES.sample }
  end
end
