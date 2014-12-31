class SwitchAuthorToAuthors < ActiveRecord::Migration
  def up
    add_column :books, :authors, :string, array: true, default: []

    update_str = 'UPDATE books SET authors = ARRAY[author]'
    ActiveRecord::Base.connection.execute(update_str)

    remove_column :books, :author
  end

  def down
    add_column :books, :author, :string

    update_str = "UPDATE books SET author = array_to_string(authors, ', ')"
    ActiveRecord::Base.connection.execute(update_str)

    remove_column :books, :authors
  end
end
