FactoryGirl.define do
  factory :book do
    title { Faker::Commerce.product_name }
    subtitle { Faker::Company.bs }
    authors { [Faker::Name.name] }
    cover_image_url { 'http://example.com/image.jpg' }
    publish_date { Date.new(2014, 1, 1) }
    isbn { Faker::Code.isbn }
    amazon_link { Faker::Internet.url }
    publisher { Faker::Company.name }
    description { Faker::Lorem.paragraph }
  end
end
