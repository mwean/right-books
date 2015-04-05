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
