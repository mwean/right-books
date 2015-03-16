require 'rails_helper'

feature 'admin ordering books' do
  given(:user) { create(:user, :admin) }
  given(:category) { create(:category) }
  given(:category2) { create(:category) }
  given!(:book) { create(:book, title: 'Some Book', category_ids: [category.id]) }
  given!(:book2) { create(:book, title: 'Different Book', category_ids: [category.id]) }
  given!(:book3) { create(:book, category_ids: [category2.id]) }
  given(:admin_books_page) { Admin::BooksPage.new }
  given(:category_page) { CategoryPage.new }

  background { sign_in_user(user) }

  scenario 'admin filters books by category and reorders them' do
    admin_books_page.load
    expect(admin_books_page).to have_books(count: 3)

    admin_books_page.filter_category(category)

    expect(admin_books_page).to have_content(book.title)
    expect(admin_books_page).to have_content(book2.title)
    expect(admin_books_page).not_to have_content(book3.title)

    first_book = admin_books_page.books.first
    second_book = admin_books_page.books.last
    first_book_text = first_book.text
    second_book_text = second_book.text

    second_book.drag_to(first_book)

    expect(admin_books_page.books.first.text).to match(second_book_text)
    expect(admin_books_page.books.last.text).to match(first_book_text)

    admin_books_page.filter_category(BlankCategory.new)

    expect(admin_books_page).to have_books(count: 3)

    category_page.load(slug: category.slug)

    expect(category_page.books.first.text).to match(second_book_text)
    expect(category_page.books.last.text).to match(first_book_text)
  end
end
