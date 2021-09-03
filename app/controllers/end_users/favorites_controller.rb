class EndUsers::FavoritesController < ApplicationController

  def index
    favorites = Favorite.where(end_user_id: current_end_user.id)
    @posts = favorites.map{|favorite| favorite.post}
    @post = Post.new
    @end_user = current_end_user
  end

  def create
    @post = Post.find(params[:post_id])
    favorite = current_end_user.favorites.new(post_id: @post.id)
    favorite.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    if @post.have_favorite?(current_end_user)
      favorite = current_end_user.favorites.find_by(post_id: @post.id)
      favorite.destroy
    else
      redirect_back(fallback_location: root_path)
    end
  end

end
