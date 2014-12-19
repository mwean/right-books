FactoryGirl.define do
  factory :book do
    title 'Really Cool Book'
    subtitle 'The Story of Being a Book'
    author 'Some Cool Guy'
    cover_image { 'http://example.com/image.jpg' }
    publish_date { Date.new(2014, 1, 1) }
  end
end
