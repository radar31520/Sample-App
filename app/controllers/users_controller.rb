class UsersController < ApplicationController
  def new
    @title = "SignUp"
  end

  def show
    @user = User.find(params[:id])
  end

end

