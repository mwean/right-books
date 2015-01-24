class AddMultipleCategoriesToBooks < ActiveRecord::Migration
  def change
    remove_column :books, :category, :integer
    add_column :books, :category_ids, :integer, array: true, default: []

    add_index :books, :category_ids, using: 'gin'
  end
end
