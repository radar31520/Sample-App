class UsersController < ApplicationController

  def show
   # if signed_in?
      @user = User.find(params[:id])
      @title = @user.name
  #  else
   #   redirect_to root_path
   # end
  end

  def new
    @user = User.new
    @title = "SignUp"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in(@user)
      flash[:success] = "Welcome to the sample app!"
      redirect_to @user
    else
      @title = "SignUp"
      render 'new'
    end

  end
end

