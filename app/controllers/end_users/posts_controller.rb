class EndUsers::PostsController < ApplicationController
before_action :correct_post_end_user, only: [:edit, :update]

  def create
    @post = Post.new(post_params)
    @post.end_user_quiz_score = current_end_user.quiz_score
    if @post.save
      redirect_to midroom_path
    else
      if current_end_user.quiz_score == 0..3
        @end_user = current_end_user
        @posts = Post.where(end_user_quiz_score: 0..3).order(created_at: "DESC")
        render '/end_users/rooms/lowroom'
      elsif current_end_user.quiz_score == 4..6
        @end_user = current_end_user
        @posts = Post.where(end_user_quiz_score: 4..6).order(created_at: "DESC")
        render '/end_users/rooms/midroom'
      else
        @end_user = current_end_user
        @posts = Post.where(end_user_quiz_score: 7..8).order(created_at: "DESC")
        render '/end_users/rooms/upperroom'
      end
    end
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
      flash[:danger] = "空のフォーム、文字数over(150字以上)は送信できません"
      redirect_to edit_post_path
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

