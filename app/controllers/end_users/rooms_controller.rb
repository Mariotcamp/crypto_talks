class EndUsers::RoomsController < ApplicationController
  before_action :logged_in_end_user, :admin_user?, :have_score
  protect_from_forgery :except => [:lowroom , :midroom, :upperroom]
  def lowroom
    low_judge
    @post = Post.new
    from = (Time.zone.now - 2.month)
    to = Time.zone.now
    posts = Post.where(end_user_quiz_score: 0..3).order(created_at: "DESC").includes(:comments, :favorites)
    @posts = posts.where(created_at: from...to)
    @end_user = current_end_user
    @ranking_end_users = EndUser.find(Relationship.group(:followed_id).order('count(followed_id) desc').limit(3).pluck(:followed_id))
  end

  def midroom
    mid_judge
    @post = Post.new
    from = (Time.zone.now - 2.month)
    to = Time.zone.now
    posts = Post.where(end_user_quiz_score: 4..6).order(created_at: "DESC").includes(:comments, :favorites)
    @posts = posts.where(created_at: from...to)
    @end_user = current_end_user
    @ranking_end_users = EndUser.find(Relationship.group(:followed_id).order('count(followed_id) desc').limit(3).pluck(:followed_id))
  end

  def upperroom
    upper_judge
    @post = Post.new
    from = (Time.zone.now - 2.month)
    to = Time.zone.now
    posts = Post.where(end_user_quiz_score: 7..8).order(created_at: "DESC").includes(:comments, :favorites)
    @posts = posts.where(created_at: from...to)
    @end_user = current_end_user
    @ranking_end_users = EndUser.find(Relationship.group(:followed_id).order('count(followed_id) desc').limit(3).pluck(:followed_id))
  end

  private
    def low_judge
      if current_end_user.quiz_score > 3
        redirect_to midroom_path
      elsif current_end_user.quiz_score > 6
        redirect_to upperroom_path
      end
    end

    def mid_judge
      if current_end_user.quiz_score <= 3
        redirect_to lowroom_path
      elsif current_end_user.quiz_score > 6
        redirect_to upperroom_path
      end
    end

    def upper_judge
      if current_end_user.quiz_score <= 3
        redirect_to lowroom_path
      elsif current_end_user.quiz_score <= 6
        redirect_to midroom_path
      end
    end
end
