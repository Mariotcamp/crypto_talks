module EndUsers::SessionsHelper
  def log_in(end_user)
    session[:end_user_id] = end_user.id
  end

  def current_end_user
    if session[:end_user_id]
      @current_end_user ||= EndUser.find_by(id: session[:end_user_id])
    end
  end

  def logged_in?
    !current_end_user.nil?
  end

  def log_out
    session.delete(:end_user_id)
    @current_end_user = nil
  end
end
