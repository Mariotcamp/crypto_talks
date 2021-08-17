class AddIndexToEndUsersEmail < ActiveRecord::Migration[6.0]
  def change
    add_index :end_users, :email, unique: true
  end
end
