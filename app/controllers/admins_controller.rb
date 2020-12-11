class AdminsController < ApplicationController
  before_action :check_admin

  def users
    @users = User.all
  end

  def results
    @results = Result.all
  end 
end
