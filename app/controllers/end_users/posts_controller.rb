class EndUsers::PostsController < ApplicationController
before_action :correct_post_end_user, only: [:edit, :update]

  def create
    @post = Post.new(post_params)
    @post.end_user_quiz_score = current_end_user.quiz_score
    @post.save
    redirect_back(fallback_location: root_path)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.order(id: "DESC")
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to midroom_path
    else
      redirect_back(fallback_location: root_path) #もしかしたらこれでfield_with_errorsの問題が解決したかも。あとは上に１行フラッシュメッセージを追加しよう。
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to midroom_path
  end

  private
    def post_params
      params.require(:post).permit(:end_user_id, :sentence)
    end

    def correct_post_end_user
      post = Post.find(params[:id])
      unless post.end_user.id == current_end_user.id
        redirect_back(fallback_location: root_path)
      end
    end
end
