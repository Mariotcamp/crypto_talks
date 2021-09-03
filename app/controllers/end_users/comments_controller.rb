class EndUsers::CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    @comments = post.comments.order(id: "DESC")
    comment = current_end_user.comments.new(comment_params)
    comment.post_id = post.id
    if comment.save
      respond_to do |format|
        format.js
      end
    else
      #エラーメッセージorフラッシュメッセージで知らせる
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    @comments = post.comments.order(id: "DESC")
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
  end

  private
    def comment_params
      params.require(:comment).permit(:sentence)
    end
end
