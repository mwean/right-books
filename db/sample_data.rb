unless Book.any?
  titles = {
    "A Nation of Takers"                  => [:economics],
    "The Pity Party"                      => [:philosophy],
    "Suicide of the West"                 => [:history],
    "Law of the Jungle"                   => [:essentials],
    "America in Retreat"                  => [:history],
    "The Black Book of the American Left" => [:philosophy],
    "Stonewalled"                         => [:history, :philosophy],
    "Hitler's First Victims"              => [:history],
    "The Undocumented Mark Steyn"         => [:biography]
  }

  categories = Category.all
  existing_books = Book.all

  titles.each do |title, category_names|
    next if existing_books.find { |book| book.title == title }

    amazon_result = AmazonSearch.new(title).results.first
    book = Book.from_amazon_result(amazon_result)
    book.category_ids = categories.select { |cat| category_names.include?(cat.name) }.map(&:id)
    book.save
  end
end

User.where(email: 'admin@example.com').first_or_create(
  admin: true,
  password: 'testme',
  first_name: 'Jimmy',
  last_name: 'Admin'
)
