class AdminUsers::HomeController < ApplicationController
  before_action :logged_in_end_user

  def top
    @end_users = EndUser.where(admin: false)
  end

end
