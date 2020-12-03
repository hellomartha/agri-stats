class UsersController < ApplicationController
  def model
    User
  end

  def show
    @resource = current_user
  end

  def columns_of_show
    [:user_name]
  end
end

