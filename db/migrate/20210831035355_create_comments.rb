class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.references :end_user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.text :sentence, null: false

      t.timestamps
    end
  end
end
