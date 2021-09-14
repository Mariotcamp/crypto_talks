class AdminUsers::HomeController < ApplicationController
  before_action :logged_in_end_user, :confirm_number_of_quizes

  def top
  end

end
