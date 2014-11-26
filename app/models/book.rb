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
#  publisher    :string
#  amazon_link  :string
#  description  :text
#  editor_notes :text
#  category     :integer
#  isbn         :string
#
# Indexes
#
#  index_books_on_category  (category)
#  index_books_on_slug      (slug) UNIQUE
#

class Book < ActiveRecord::Base
  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

  def self.build_from_amazon(query)
    search_result = AmazonSearch.new(query)

    new(
      title: search_result.title,
      subtitle: search_result.subtitle,
      author: search_result.author,
      publish_date: search_result.publish_date,
      cover_image: search_result.cover_image,
      publisher: search_result.publisher,
      description: search_result.description,
      amazon_link: search_result.amazon_link,
      isbn: search_result.isbn
    )
  end

  def self.new_releases(count = nil)
    order(publish_date: :desc).limit(count)
  end

  def slug_candidates
    [:title, %i(title author)]
  end
end
