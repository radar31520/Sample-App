class SessionsController < ApplicationController
  def new
    @title = "SignIn"
  end

  def create
  end

  def destroy
    @title = "SignOut"
  end

end

