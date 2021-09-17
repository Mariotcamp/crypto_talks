class EndUsers::SessionsController < ApplicationController
  def new
    @quizes = Quiz.all
  end

  def create
    @end_user = EndUser.find_by(name: params[:session][:name])
    if @end_user && @end_user.authenticate(params[:session][:password])
      if @end_user.is_available
        if @end_user.quiz_score || @end_user.admin?
          log_in @end_user
          params[:session][:remember_me] == '1'? remember(@end_user) : forget(@end_user)
          redirect_to quizes_path
        else
          quiz_is_available?
        end
      else
        @quizes = Quiz.all
        flash.now[:danger] = "退会済みもしくは運営によってbanされたユーザーです"
        render 'new'
      end
    else
      @quizes = Quiz.all
      flash.now[:danger] = "ユーザー名またはパスワードが正しくありません。"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private
  def quiz_is_available?
    @quizes = Quiz.all
    if @quizes.count < 8
      flash[:danger] = "現在クイズのメンテナンス中です。少々お待ちください"
      redirect_to login_path
    else
      log_in @end_user
      params[:session][:remember_me] == '1'? remember(@end_user) : forget(@end_user)
      redirect_to quizes_path
    end
  end

end
