class CreateEndUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :end_users do |t|
      t.string :name, null: false
      t.string :email, null: false

      t.timestamps
    end
  end
end
