require 'rails_helper'

feature 'signing in' do
  scenario 'user clicks sign in link in header and signs in', :js do
    user = create(:user, password: 'password')
    home_page = HomePage.new
    sign_in_page = SignInPage.new

    home_page.load
    home_page.navbar.sign_in_link.click

    expect(sign_in_page).to be_displayed

    sign_in_page.email_field.set(user.email)
    sign_in_page.password_field.set('password')
    sign_in_page.submit_button.click

    expect(home_page).to be_displayed
    expect(home_page.navbar).to have_content(user.first_name.upcase)
  end
end
