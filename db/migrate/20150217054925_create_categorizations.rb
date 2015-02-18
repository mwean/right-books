class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.references :book, index: true
      t.references :category, index: true
      t.integer :display_order

      t.timestamps null: false
    end

    add_foreign_key :categorizations, :books
    add_foreign_key :categorizations, :categories
  end
end
