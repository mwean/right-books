# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  email                           :string           not null
#  crypted_password                :string           not null
#  salt                            :string           not null
#  created_at                      :datetime
#  updated_at                      :datetime
#  remember_me_token               :string
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  failed_logins_count             :integer          default("0")
#  lock_expires_at                 :datetime
#  unlock_token                    :string
#  admin                           :boolean          default("false")
#  first_name                      :string
#  last_name                       :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_remember_me_token     (remember_me_token)
#  index_users_on_reset_password_token  (reset_password_token)
#

class User < ActiveRecord::Base
  has_many :comments

  authenticates_with_sorcery!

  validates :email, uniqueness: true, presence: true
  validates :password, presence: :true, on: :create
  validates :password, confirmation: true
  validates :password_confirmation, presence: true, on: :create
  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
