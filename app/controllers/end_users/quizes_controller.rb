class EndUsers::QuizesController < ApplicationController
  before_action :logged_in_end_user, :admin_user?

  def take
    @quizes = Quiz.all
    @end_user = current_end_user
    if @end_user.quiz_score.nil?
      #クイズ画面へ遷移
    else
      num = @end_user.posts.count
      if num <= 9
        flash[:danger] = "投稿数が" + (10 - num ).to_s + "件不足しています"
        redirect_to lowroom_path
      elsif @quizes.count < 8
        flash[:danger] = "現在クイズのメンテナンスをしています。しばらく時間を置いてから再度挑戦してください。"
        redirect_to lowroom_path
      else
        #クイズ画面へ遷移
      end
    end
  end

  def result
    @quizes = Quiz.all
    num = 1
    current_end_user.quiz_score = 0
    #このクイズ番号に動的に応じれられるシンボル設計でないと、クイズ追加したときにエラーが出てしまう。→一様クイズ番号に応じてeach
    #を効かせられるようにはなったが、num = 1の設計だと、問題を削除したときにidがずれてしまう。→いや、ここはquizのidではなくviewのname
    #name属性から参照しているから、quiz.idが4とかでもそれが一問目の問題ならviewでのname属性はquiz1になるから大丈夫でした。
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
        redirect_to lowroom_path
      elsif score <= 6
        redirect_to midroom_path
      elsif score <= 8
        redirect_to upperroom_path
      else
        flash[:danger] = "無効なスコア。もう一度クイズに答えてください"
        current_end_user.update_attribute(:quiz_score, null)
      end
    end
  end

end
