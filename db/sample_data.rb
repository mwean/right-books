unless Book.any?
  titles = {
    "A Nation of Takers"                  => ['Economics'],
    "The Pity Party"                      => ['Political Philosophy'],
    "Suicide of the West"                 => ['History'],
    "Law of the Jungle"                   => ['Essentials'],
    "America in Retreat"                  => ['History'],
    "The Black Book of the American Left" => ['Political Philosophy'],
    "Stonewalled"                         => ['History', 'Political Philosophy'],
    "Hitler's First Victims"              => ['History'],
    "The Undocumented Mark Steyn"         => ['Biography & Memoir']
  }

  categories = Category.all

  titles.each do |title, category_names|
    amazon_result = AmazonSearch.new(title).results.first
    book = Book.from_amazon_result(amazon_result)
    book.category_ids = categories.select { |cat| category_names.include?(cat.name) }.map(&:id)
    book.save
  end
end

User.where(email: 'admin@example.com').first_or_create(
  admin: true,
  password: 'testme',
  name: 'Admin'
)
