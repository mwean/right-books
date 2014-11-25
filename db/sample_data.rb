require 'faker'

unless Book.any?
  titles = [
    "A Nation of Takers",
    "The Pity Party",
    "Suicide of the West",
    "Law of the Jungle",
    "America in Retreat",
    "The Black Book of the American Left",
    "Stonewalled",
    "Hitler's First Victims",
    "The Undocumented Mark Steyn"
  ]

  titles.each do |title|
    book = Book.build_from_amazon(title)
    book.save
  end
end
