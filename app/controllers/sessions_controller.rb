class SessionsController < ApplicationController

  def new
    @title = "SignIn"
  end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid Email/Passord Combination"
       @title = "SignIn"
      render 'new'
    else
      sign_in user
      redirect_to user
    end
  end

  def destroy
    @title = "SignOut"
  end

end

