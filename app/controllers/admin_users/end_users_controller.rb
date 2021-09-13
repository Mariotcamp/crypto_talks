class AdminUsers::EndUsersController < ApplicationController
before_action :finished_log_in_as_admin

  def index
    @end_users = EndUser.where(admin: false)
  end

  def recover
    end_user = EndUser.find(params[:id])
    end_user.update_attribute(:is_available, true)
    end_user.save
    redirect_back(fallback_location: root_path)
  end

  def ban
    end_user = EndUser.find(params[:id])
    end_user.update_attribute(:is_available, false)
    end_user.save
    redirect_back(fallback_location: root_path)
  end

end
