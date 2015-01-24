class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true
      t.references :book, index: true
      t.text :body
      t.string :ancestry

      t.timestamps null: false
    end
  end
end
