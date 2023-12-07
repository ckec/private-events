class RemoveUsernameAndAddIndexToEmail < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :username
    add_index :users, :email, unique: true
  end
end