class AddEndUserQuizScoreToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :end_user_quiz_score, :integer
  end
end
