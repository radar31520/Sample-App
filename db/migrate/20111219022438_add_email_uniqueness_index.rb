class AddEmailUniquenessIndex < ActiveRecord::Migration
  def up
    add_index :user, :email, :unique => true
  end

  def down
    remove_index :users, :email
  end
end

