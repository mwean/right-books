require 'rails_helper'

feature 'home page' do
  scenario 'user clicks on new release book and goes to book page' do
    book = create(:book)
    home_page = HomePage.new
    home_page.load

    home_page.new_releases.click_book(book)

    book_page = BookPage.new
    expect(book_page).to be_displayed
  end
end
