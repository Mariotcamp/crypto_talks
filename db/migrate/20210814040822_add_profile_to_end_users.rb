class AddProfileToEndUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :end_users, :profile, :string
  end
end
