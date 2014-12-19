# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  book_id    :integer
#  body       :text
#  ancestry   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_comments_on_book_id  (book_id)
#  index_comments_on_user_id  (user_id)
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  has_ancestry

  validates :user, presence: true
  validates :body, presence: true
end
