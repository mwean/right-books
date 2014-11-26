require 'rails_helper'

feature 'home page' do
  let(:home_page) { HomePage.new }

  background do
    @book = create(:book)
  end

  scenario 'user clicks on new release book and goes to book page' do
    home_page.load
    home_page.new_releases.click_book(@book)

    book_page = BookPage.new
    expect(book_page).to be_displayed
  end

  scenario 'user clicks on new releases "See More" link' do
    home_page.load
    home_page.new_releases.see_more.click

    new_releases_page = NewReleasesPage.new
    expect(new_releases_page).to be_displayed
    expect(page).to have_content(@book.title)
  end

  scenario 'user clicks on a category to browse' do
    category = create(:category)
    book = create(:book, category_ids: [category.id])
    home_page.load
    home_page.categories.click_category(category.name)

    category_page = CategoryPage.new
    expect(category_page).to be_displayed
    expect(page).to have_content(book.title)
  end
end
