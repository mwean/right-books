class SplitUserNameField < ActiveRecord::Migration
  def up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string

    User.reset_column_information

    User.find_each do |user|
      names = user.name.split(/\s+/)
      user.last_name = names.pop
      user.first_name = names.join(' ')
      user.save!
    end

    remove_column :users, :name
  end

  def down
    add_column :users, :name, :string

    User.reset_column_information

    User.find_each do |user|
      user.name = [user.first_name, user.last_name].compact.join(' ')
      user.save!
    end

    remove_column :users, :first_name
    remove_column :users, :last_name
  end
end
