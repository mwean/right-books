class RenameCoverImage < ActiveRecord::Migration
  def change
    rename_column :books, :cover_image, :cover_image_url
  end
end
