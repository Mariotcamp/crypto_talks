module EndUsers::SessionsHelper
  def log_in(end_user)
    session[:end_user_id] = end_user.id
  end

  def remember(end_user)
    end_user.remember
    cookies.permanent.signed[:end_user_id] =  end_user.id
    cookies.permanent[:remember_token] = end_user.remember_token
  end

  def current_end_user
    if (end_user_id = session[:end_user_id])
      @current_end_user ||= EndUser.find_by(id: end_user_id)
    else (end_user_id = cookies.signed[:end_user_id])
      end_user = EndUser.find_by(id: end_user_id)
      if end_user && end_user.authenticated?(cookies[:remember_token])
        log_in (end_user)
        @current_end_user = end_user
      end
    end
  end

  def logged_in?
    !current_end_user.nil?
  end

  def forget(end_user)
    end_user.forget
    cookies.delete(:end_user_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_end_user)
    session.delete(:end_user_id)
    @current_end_user = nil
  end

end
