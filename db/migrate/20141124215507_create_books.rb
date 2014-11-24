class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :subtitle
      t.string :author
      t.string :cover_image
      t.date   :publish_date
      t.string :slug, null: false

      t.timestamps null: false
    end

    add_index :books, :slug, unique: true
  end
end
