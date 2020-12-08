class AdminsController < ApplicationController
  before_action :check_admin
  
  def check_admin
    render_404 unless (current_user&.id == 1 && current_user&.uid == "347816803")
  end

  def users
    @users = User.all
  end

  def results
    @results = Result.all
  end 
end
