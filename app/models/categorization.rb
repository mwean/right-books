# == Schema Information
#
# Table name: categorizations
#
#  id            :integer          not null, primary key
#  book_id       :integer
#  category_id   :integer
#  display_order :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_categorizations_on_book_id      (book_id)
#  index_categorizations_on_category_id  (category_id)
#

class Categorization < ActiveRecord::Base
  belongs_to :book
  belongs_to :category

  def self.update_display_order(category_id:, book_ids:)
    order_map = book_ids.map.with_index { |id, i| [id, i] }.to_h

    where(category_id: category_id).each do |categorization|
      categorization.update_attributes(display_order: order_map[categorization.book_id])
    end
  end
end
