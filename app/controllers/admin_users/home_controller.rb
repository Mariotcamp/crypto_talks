class AdminUsers::HomeController < ApplicationController
  before_action :logged_in_end_user, :finished_log_in_as_admin, :confirm_number_of_quizes

  def top
  end

end
