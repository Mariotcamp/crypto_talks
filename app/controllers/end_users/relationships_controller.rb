class EndUsers::RelationshipsController < ApplicationController
  before_action :logged_in_end_user

  def create
    @end_user = EndUser.find(params[:relationship][:followed_id])
    current_end_user.follow(@end_user)
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  def destroy
    @end_user = Relationship.find(params[:id]).followed
    current_end_user.unfollow(@end_user)
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end
end
