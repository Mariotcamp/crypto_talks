class AddQuizScoreToEndUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :end_users, :quiz_score, :integer
  end
end
