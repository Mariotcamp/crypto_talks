class AddIndexToEndUsersName < ActiveRecord::Migration[6.0]
  def change
    add_index :end_users, :name, unique: true
  end
end
