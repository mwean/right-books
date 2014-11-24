# == Schema Information
#
# Table name: books
#
#  id           :integer          not null, primary key
#  title        :string
#  subtitle     :string
#  author       :string
#  cover_image  :string
#  publish_date :date
#  slug         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_books_on_slug  (slug) UNIQUE
#

class Book < ActiveRecord::Base
  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

  def self.new_releases
    order(publish_date: :desc).limit(5)
  end

  def slug_candidates
    [:title, %i(title author)]
  end
end
