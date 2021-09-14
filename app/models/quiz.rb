class Quiz < ApplicationRecord
  validates :question, presence: true
  validates :option1, presence: true
  validates :option2, presence: true
  validates :option3, presence: true
  validates :option4, presence: true
  validates :answer_number, presence: true
  validate :check_number_of_quiz

  def check_number_of_quiz
    quizes = Quiz.all
    if quizes && quizes.count >= 8
      errors.add(:quiz, "クイズは８問以上登録できません")
    end
  end
end
