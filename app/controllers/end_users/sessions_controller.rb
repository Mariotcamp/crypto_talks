class EndUsers::SessionsController < ApplicationController
  def new
  end

  def create
    end_user = EndUser.find_by(name: params[:session][:name])
    if end_user && end_user.authenticate(params[:session][:password])
      log_in end_user
      params[:session][:remember_me] == '1'? remember(end_user) : forget(end_user)
      redirect_to quizes_path
    else
      flash.now[:danger] = "ユーザー名またはパスワードが正しくありません。"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
