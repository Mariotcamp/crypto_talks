class EndUsers::EndUsersController < ApplicationController
  def new
    @end_user = EndUser.new
  end

  def create
    @end_user = EndUser.new(end_user_params)
    if @end_user.save
      log_in (@end_user)
      flash[:success] = "ユーザー登録に成功しました"
      redirect_to quizes_path
    else
      render 'new'
    end
  end

  private
    def end_user_params
      params.require(:end_user).permit(:name, :email, :password, :password_confirmation)
    end
end
