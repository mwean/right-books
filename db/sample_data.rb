require 'faker'

unless Book.any?
  10.times do
    create(
      :book,
      title: Faker::Company.catch_phrase.titleize,
      subtitle: Faker::Company.catch_phrase.titleize,
      author: Faker::Name.name,
      publish_date: (1.month.ago.to_date..Date.yesterday).to_a.sample
    )
  end
end
