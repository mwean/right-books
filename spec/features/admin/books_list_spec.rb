require 'rails_helper'

feature 'admin book list page' do
  given(:user) { create(:user, :admin) }
  given!(:book) { create(:book) }
  given(:admin_books_page) { Admin::BooksPage.new }

  background { sign_in_user(user) }

  scenario 'admin sees a list of existing books and adds a new one' do
    new_book_page = Admin::NewBookPage.new
    new_book = build_stubbed(:book)
    FakeAmazon.stub_search_results([new_book])
    admin_books_page.load

    expect(admin_books_page).to have_books(count: 1)

    admin_books_page.new_book_button.click
    admin_books_page.wait_for_book_search_modal
    book_search_modal = admin_books_page.book_search_modal
    book_search_modal.search_field.set(new_book.title)
    book_search_modal.wait_for_results

    expect(book_search_modal).to have_results(count: 1)
    expect(book_search_modal.results.first).to have_content(new_book.title)

    book_search_modal.results.first.click

    expect(new_book_page).to be_displayed
  end
end
