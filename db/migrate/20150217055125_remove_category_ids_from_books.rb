class RemoveCategoryIdsFromBooks < ActiveRecord::Migration
  def up
    Book.find_each do |book|
      next if book.category_ids.none?

      categories = Category.find(book.attributes['category_ids'])
      book.categories = categories
    end

    remove_column :books, :category_ids
    remove_column :books, :display_order
  end

  def down
    add_column :books, :category_ids, :integer, array: true, default: []
  end
end
