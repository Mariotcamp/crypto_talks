class EndUsers::CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = current_end_user.comments.new(comment_params)
    comment.post_id = post.id
    if comment.save
      redirect_back(fallback_location: root_path)
    else
      #エラーメッセージorフラッシュメッセージで知らせる
    end
  end

  def destroy
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private
    def comment_params
      params.require(:comment).permit(:sentence)
    end
end
