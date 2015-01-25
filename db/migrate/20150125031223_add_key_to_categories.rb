class AddKeyToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :key, :string
    add_index :categories, :key
  end
end
