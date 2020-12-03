class UsersController < ApplicationController
  def model
    User
  end

  def show
    @user = current_user
    @results = Result.where(user: current_user).order(id: "DESC")
  end

  def columns_of_show
    [:user_name]
  end
end

