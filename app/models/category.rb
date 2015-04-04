# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  key        :string
#
# Indexes
#
#  index_categories_on_key   (key)
#  index_categories_on_slug  (slug) UNIQUE
#

class Category < ActiveRecord::Base
  extend FriendlyId

  has_many :categorizations, dependent: :destroy
  has_many :books, through: :categorizations

  friendly_id :name, use: :slugged

  def self.with_key(keys)
    by_key(keys).first
  end

  def self.by_key(keys)
    keys_ary = Array(keys).map(&:to_s)
    where(key: keys_ary)
  end

  def ordered_books
    books.order(Categorization.arel_table[:display_order].asc)
  end
end
