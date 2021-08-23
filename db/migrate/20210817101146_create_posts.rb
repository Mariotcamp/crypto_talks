class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.integer :end_user_id, null: false
      t.text :sentence, null: false

      t.timestamps
    end
  end
end
