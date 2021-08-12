class CreateQuizzes < ActiveRecord::Migration[6.0]
  def change
    create_table :quizzes do |t|
      t.string :question, null: false
      t.string :option1, null: false
      t.string :option2, null: false
      t.string :option3, null: false
      t.string :option4, null: false
      t.integer :answer_number

      t.timestamps
    end
  end
end
