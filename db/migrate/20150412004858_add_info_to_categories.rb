class AddInfoToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :description, :text
    add_column :categories, :image_url, :string
  end
end
