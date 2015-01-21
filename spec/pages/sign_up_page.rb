class SignUpPage < SitePrism::Page
  set_url '/sign_up'
  set_url_matcher(/sign_up/)

  element :email_field, '#user_email'
  element :password_field, '#user_password'
  element :password_confirmation_field, '#user_password_confirmation'
  element :first_name_field, '#user_first_name'
  element :last_name_field, '#user_last_name'
  element :submit_button, 'input[type="submit"]'
end
