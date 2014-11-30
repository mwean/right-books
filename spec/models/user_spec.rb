require 'rails_helper'

describe User do
  it 'requires a unique email' do
    first_user = create(:user)

    new_user = build(:user, email: first_user.email)

    expect(new_user).not_to be_valid
  end

  it { is_expected.not_to allow_value(nil).for(:email) }
  it { is_expected.not_to allow_value('').for(:email) }

  it { is_expected.not_to allow_value(nil).for(:password) }
  it { is_expected.not_to allow_value('').for(:password) }
end
