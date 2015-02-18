require 'rails_helper'

feature 'home page' do
  given(:home_page) { HomePage.new }

  describe 'with a book' do
    background { @book = create(:book) }

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

  scenario 'user clicks sign up link and creates an account' do
    sign_up_page = SignUpPage.new
    user = build_stubbed(:user)
    home_page.load
    home_page.navbar.sign_up_link.click

    expect(sign_up_page).to be_displayed

    sign_up_page.email_field.set(user.email)
    sign_up_page.password_field.set(user.password)
    sign_up_page.password_confirmation_field.set(user.password)
    sign_up_page.first_name_field.set(user.first_name)
    sign_up_page.last_name_field.set(user.last_name)
    sign_up_page.submit_button.click

    expect(home_page).to be_displayed
    expect(home_page.navbar).to have_content(user.first_name.upcase)
    expect(home_page.navbar).to have_no_sign_up_link
    expect(home_page.navbar).to have_no_sign_in_link
  end
end
