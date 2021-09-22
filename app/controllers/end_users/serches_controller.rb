class EndUsers::SerchesController < ApplicationController
  before_action :logged_in_end_user, :upper_end_user?
  def index
    @posts = Post.where('sentence LIKE ?', '%'+ params[:coin] +'%').order(id: "DESC")
    unless @posts.any?
      flash.now[:danger] = "検索されたコインに関する投稿は見当たりません。"
    end
    @ranking_end_users = EndUser.find(Relationship.group(:followed_id).order('count(followed_id) desc').limit(3).pluck(:followed_id))
  end

  private
    def upper_end_user?
      if current_end_user.quiz_score <= 6
        redirect_to midroom_path
      end
    end
end
