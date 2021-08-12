class ApplicationController < ActionController::Base
  include EndUsers::SessionsHelper

  def logged_in_end_user
    unless logged_in?
      flash[:danger] = "ログインしてください"
      redirect_to login_path
    end
  end
end
