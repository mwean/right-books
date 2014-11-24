FactoryGirl.define do
  factory :book do
    title 'Really Cool Book'
    subtitle 'The Story of Being a Book'
    author 'Some Cool Guy'
    cover_image { "http://lorempixel.com/600/800/business/#{(1..10).to_a.sample}" }
    publish_date { Date.new(2014, 1, 1) }
  end
end
