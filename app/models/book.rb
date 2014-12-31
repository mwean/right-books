# == Schema Information
#
# Table name: books
#
#  id              :integer          not null, primary key
#  title           :string
#  subtitle        :string
#  cover_image_url :string
#  publish_date    :date
#  slug            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  publisher       :string
#  amazon_link     :string
#  description     :text
#  editor_notes    :text
#  isbn            :string
#  category_ids    :integer          default("{}"), is an Array
#  authors         :string           default("{}"), is an Array
#
# Indexes
#
#  index_books_on_category_ids  (category_ids)
#  index_books_on_slug          (slug) UNIQUE
#

class Book < ActiveRecord::Base
  extend FriendlyId

  has_many :comments

  friendly_id :slug_candidates, use: :slugged

  def self.from_amazon_result(result)
    new(
      title:           result.title,
      subtitle:        result.subtitle,
      authors:         result.authors,
      publish_date:    Date.parse(result.publish_date),
      cover_image_url: result.cover_image_url,
      publisher:       result.publisher,
      description:     result.description,
      amazon_link:     result.amazon_link,
      isbn:            result.isbn
    )
  end

  def self.new_releases(count = nil)
    order(publish_date: :desc).limit(count)
  end

  def self.with_category_id(category_id)
    array_str = Arel::Nodes.build_quoted("{#{category_id}}")
    where(Arel::Nodes::InfixOperation.new('@>', arel_table[:category_ids], array_str))
  end

  def slug_candidates
    [:title, %i(title authors_sentence)]
  end

  def authors_sentence
    authors.to_sentence
  end

  def categories
    Category.where(id: category_ids)
  end

  def normalize_friendly_id(value)
    value.to_s.gsub(/(?<=\w)'s\b/i, 's').parameterize
  end
end
