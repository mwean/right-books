unless Book.any?
  titles = {
    'A Nation of Takers'                  => %w(conservatism),
    'The Pity Party'                      => %w(philosophy),
    'Suicide of the West'                 => %w(history),
    'Law of the Jungle'                   => %w(essentials),
    'America in Retreat'                  => %w(history),
    'The Black Book of the American Left' => %w(philosophy),
    'Stonewalled'                         => %w(history, :philosophy),
    "Hitler's First Victims"              => %w(history),
    'The Undocumented Mark Steyn'         => %w(biography)
  }

  categories = Category.all
  existing_books = Book.all

  titles.each do |title, category_keys|
    next if existing_books.find { |book| book.title == title }

    amazon_result = AmazonSearch.new(title).results.first
    book = Book.from_amazon_result(amazon_result)
    book.category_ids = categories.select { |cat| category_keys.include?(cat.key) }.map(&:id)
    book.save
  end
end

User.where(email: 'admin@example.com').first_or_create(
  admin: true,
  password: 'testme',
  first_name: 'Jimmy',
  last_name: 'Admin'
)

essentials = Category.with_key(:essentials)

if essentials.description.blank? || essentials.image_url.blank?
  essentials.update_attributes(
    description: Faker::Lorem.paragraph,
    image_url: 'http://lorempixel.com/output/city-q-c-640-480-1.jpg'
  )
end
