class AddIsAvailableToEndUser < ActiveRecord::Migration[6.0]
  def change
    add_column :end_users, :is_available, :boolean, default: true
  end
end
