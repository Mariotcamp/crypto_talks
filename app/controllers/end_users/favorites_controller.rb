class EndUsers::FavoritesController < ApplicationController
  before_action :logged_in_end_user

  def index
    favorites = Favorite.where(end_user_id: current_end_user.id).includes(:post)
    posts = favorites.order(id: "DESC").map{|favorite| favorite.post}
    @posts = Kaminari.paginate_array(posts).page(params[:page]).per(10)
    @post = Post.new
    @end_user = current_end_user
    @ranking_end_users = EndUser.find(Relationship.group(:followed_id).order('count(followed_id) desc').limit(3).pluck(:followed_id))
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
    end
  end

end
