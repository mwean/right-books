class NewReleasesSection < SitePrism::Section
  elements :books, '.book'

  def click_book(book)
    books.find { |el| el.text.include?(book.title) }.click
  end
end
