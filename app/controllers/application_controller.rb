class ApplicationController < ActionController::Base
  include EndUsers::SessionsHelper

  def logged_in_end_user
    unless logged_in?
      flash[:danger] = "ログインしてください"
      redirect_to login_path
    end
  end

  def admin_user?
    if current_end_user.admin?
      redirect_to admin_users_path
    end
  end

  def finished_log_in_as_admin
    unless current_end_user.admin?
      redirect_to root_path
    end
  end

  def finished_log_in
    if logged_in?
      redirect_to midroom_path
    end
  end

  def have_score
    if current_end_user.quiz_score.nil?
      flash[:danger] = "クイズを完了後、ご利用いただける機能です"
      redirect_to quizes_path
    end
  end

  def confirm_number_of_quizes
    @quiz = Quiz.all
    if @quiz.count < 8
      flash[:danger] = "クイズは常に8問用意してください"
      redirect_to new_admin_users_quize_path
    end
  end

end
