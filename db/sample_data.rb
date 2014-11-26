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
    book = Book.build_from_amazon(title)
    book.category_ids = categories.select { |cat| category_names.include?(cat.name) }.map(&:id)
    book.save
  end
end
