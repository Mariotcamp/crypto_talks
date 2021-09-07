class AddAdminToEndUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :end_users, :admin, :boolean, default: false
  end
end
