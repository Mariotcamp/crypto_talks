class AdminUsers::QuizesController < ApplicationController
before_action :finished_log_in_as_admin
before_action :confirm_number_of_quizes, except: [:new, :create]

  def index
    @quizes = Quiz.all
  end

  def new
    @quiz = Quiz.new
  end

  def create
    @quiz = Quiz.new(quiz_params)
    if @quiz.save
      redirect_to admin_users_quizes_path
    else
      render 'admin_users/quizes/new'
      #元画面にリダイレクトして、エラーメッセージ表示
    end
  end

  def destroy
    @quiz = Quiz.find(params[:id])
    @quiz.destroy
    @quizes = Quiz.all
    if @quizes.count < 8
      flash[:danger] = "クイズは常に8問用意してください"
      redirect_to new_admin_users_quize_path
    end
  end

  private
    def quiz_params
      params.require(:quiz).permit(:question, :option1, :option2, :option3, :option4, :answer_number)
    end

end
