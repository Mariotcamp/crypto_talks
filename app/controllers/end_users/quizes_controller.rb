class EndUsers::QuizesController < ApplicationController
  before_action :logged_in_end_user, :admin_user?, :upper_end_user?

  def take
    @quizes = Quiz.all
    @end_user = current_end_user
    if @end_user.quiz_score.nil?
      #クイズ画面へ遷移
    else
      num = @end_user.posts.count
      if num <= 9
        @message = "投稿数が" + (10 - num ).to_s + "件不足しています"
        if @end_user.quiz_score <= 3
          @post = Post.new
          from = (Time.zone.now - 7.day)
          to = Time.zone.now
          posts = Post.where(end_user_quiz_score: 0..3).order(created_at: "DESC").includes(:comments, :favorites)
          @posts = posts.where(created_at: from...to)
          @ranking_end_users = EndUser.find(Relationship.group(:followed_id).order('count(followed_id) desc').limit(3).pluck(:followed_id))
          render 'end_users/rooms/lowroom'
        else
          @post = Post.new
          from = (Time.zone.now - 7.day)
          to = Time.zone.now
          posts = Post.where(end_user_quiz_score: 4..6).order(created_at: "DESC").includes(:comments, :favorites)
          @posts = posts.where(created_at: from...to)
          @ranking_end_users = EndUser.find(Relationship.group(:followed_id).order('count(followed_id) desc').limit(3).pluck(:followed_id))
          render 'end_users/rooms/midroom'
        end
      elsif @quizes.count < 8
        @message = "現在クイズのメンテナンス中です。時間を置いてから挑戦してください。"
        if @end_user.quiz_score <= 3
          @post = Post.new
          from = (Time.zone.now - 7.day)
          to = Time.zone.now
          posts = Post.where(end_user_quiz_score: 0..3).order(created_at: "DESC").includes(:comments, :favorites)
          @posts = posts.where(created_at: from...to)
          @ranking_end_users = EndUser.find(Relationship.group(:followed_id).order('count(followed_id) desc').limit(3).pluck(:followed_id))
          render 'end_users/rooms/lowroom'
        else
          @post = Post.new
          from = (Time.zone.now - 7.day)
          to = Time.zone.now
          posts = Post.where(end_user_quiz_score: 4..6).order(created_at: "DESC").includes(:comments, :favorites)
          @posts = posts.where(created_at: from...to)
          @ranking_end_users = EndUser.find(Relationship.group(:followed_id).order('count(followed_id) desc').limit(3).pluck(:followed_id))
          render 'end_users/rooms/midroom'
        end
      else
        #クイズ画面へ遷移
      end
    end
  end

  def result
    if num = current_end_user.quiz_score
      if num <= 3
        @level = "Lowroom"
      else
        @level = "Midroom"
      end
    end
    @quizes = Quiz.all
    num = 1
    current_end_user.quiz_score = 0
    @quizes.each do |quiz|
      quiz_num = "quiz#{num}".intern
      num += 1
      if answer_num = params.dig(quiz_num, :answer_num)
        if answer_num.to_i == quiz.answer_number
          current_end_user.quiz_score += 1
        end
      else
        @error = 1
        flash[:danger] = "未回答のクイズがあります。全てのクイズに回答してください"
        redirect_to quizes_path
        break
      end
    end
    unless @error
      current_end_user.update_attribute(:quiz_score, current_end_user.quiz_score)
      score = current_end_user.quiz_score
      if score <= 3
        if @level
          @level_message = @level + "からLowroomへ移動しました"
        end
        @post = Post.new
        from = (Time.zone.now - 7.day)
        to = Time.zone.now
        posts = Post.where(end_user_quiz_score: 0..3).order(created_at: "DESC").includes(:comments, :favorites)
        @posts = posts.where(created_at: from...to)
        @end_user = current_end_user
        @ranking_end_users = EndUser.find(Relationship.group(:followed_id).order('count(followed_id) desc').limit(3).pluck(:followed_id))
        render 'end_users/rooms/lowroom'
      elsif score <= 6
        if @level
          @level_message = @level + "からMidroomへ移動しました"
        end
        @post = Post.new
        from = (Time.zone.now - 7.day)
        to = Time.zone.now
        posts = Post.where(end_user_quiz_score: 4..6).order(created_at: "DESC").includes(:comments, :favorites)
        @posts = posts.where(created_at: from...to)
        @end_user = current_end_user
        @ranking_end_users = EndUser.find(Relationship.group(:followed_id).order('count(followed_id) desc').limit(3).pluck(:followed_id))
        render 'end_users/rooms/midroom'
      elsif score <= 8
        if @level
          @level_message = @level + "からUpperroomへ移動しました"
        end
        @post = Post.new
        from = (Time.zone.now - 7.day)
        to = Time.zone.now
        posts = Post.where(end_user_quiz_score: 7..8).order(created_at: "DESC").includes(:comments, :favorites)
        @posts = posts.where(created_at: from...to)
        @end_user = current_end_user
        @ranking_end_users = EndUser.find(Relationship.group(:followed_id).order('count(followed_id) desc').limit(3).pluck(:followed_id))
        render 'end_users/rooms/upperroom'
      else
        flash[:danger] = "無効なスコア。もう一度クイズに答えてください"
        current_end_user.update_attribute(:quiz_score, null)
      end
    end
  end

  private
    def upper_end_user?
      if score = current_end_user.quiz_score
        if score >= 7
          redirect_to upperroom_path
        end
      end
    end
end
