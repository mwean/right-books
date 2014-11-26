class NewReleasesSection < SitePrism::Section
  elements :books, '.book'
  element :see_more, '.section__link a'

  def click_book(book)
    books.find { |el| el.text.include?(book.title) }.click
  end
end
