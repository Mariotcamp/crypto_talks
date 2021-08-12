class ChangeColumnToQuiz < ActiveRecord::Migration[6.0]
  def up
    change_column :quizzes, :answer_number, :integer, null: false
  end

  # 変更前の状態
  def down
    change_column :quizzes, :answer_number, :integer, null: true
  end
end
