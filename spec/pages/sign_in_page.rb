class SignInPage < SitePrism::Page
  set_url '/sign_in'
  set_url_matcher(/sign_in/)

  element :email_field, '#email'
  element :password_field, '#password'
  element :submit_button, 'input[type="submit"]'
end
