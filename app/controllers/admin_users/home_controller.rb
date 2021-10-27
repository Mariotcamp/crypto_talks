class AdminUsers::HomeController < ApplicationController
  before_action :logged_in_end_user, :finished_log_in_as_admin, :confirm_number_of_quizes
  protect_from_forgery :except => [:top]
  def top
  end

end
