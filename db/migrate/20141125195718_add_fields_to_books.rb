class AddFieldsToBooks < ActiveRecord::Migration
  def change
    add_column :books, :publisher, :string
    add_column :books, :amazon_link, :string
    add_column :books, :description, :text
    add_column :books, :editor_notes, :text
    add_column :books, :category, :integer
    add_column :books, :isbn, :string

    add_index :books, :category
  end
end
