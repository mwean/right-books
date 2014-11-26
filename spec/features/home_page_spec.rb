require 'rails_helper'

feature 'home page' do
  let(:home_page) { HomePage.new }

  background do
    @book = create(:book)
    home_page.load
  end

  scenario 'user clicks on new release book and goes to book page' do
    home_page.new_releases.click_book(@book)

    book_page = BookPage.new
    expect(book_page).to be_displayed
  end

  scenario 'user clicks on new releases "See More" link' do
    home_page.new_releases.see_more.click

    new_releases_page = NewReleasesPage.new
    expect(new_releases_page).to be_displayed
    expect(page).to have_content(@book.title)
  end
end
