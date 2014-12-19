module AuthHelpers
  def sign_in_user(user = create(:user))
    page.set_rack_session(user_id: user.id)
    user
  end
end

RSpec.configure { |config| config.include(AuthHelpers, type: :feature) }
