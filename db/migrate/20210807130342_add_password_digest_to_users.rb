class AddPasswordDigestToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :end_users, :password_digest, :string, null: false
  end
end
