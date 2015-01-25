FactoryGirl.define do
  factory :category do
    transient do
      category_info = [
        [:fiction, 'Fiction'],
        [:history, 'History'],
        [:biography, 'Biography & Memoir'],
        [:philosophy, 'Political Philosophy'],
        [:culture, 'Culture'],
        [:economics, 'Economics'],
        [:essentials, 'Essentials']
      ]

      category_data category_info.sample
    end

    key { category_data.first }
    name { category_data.last }
  end
end
