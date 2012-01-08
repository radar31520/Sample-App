require 'spec_helper'

describe SessionsController do
  render_views

  describe "GET 'new'" do

    it "it should be succesful" do
      get 'new'
      response.should be_success
    end

    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Ruby on Rails Tutorial Sample App | SignIn")
    end
  end

  describe "POST 'create'" do

    describe "success" do

      before(:each) do
        @user = Factory(:user)
        @attr = {:email => @user.email , :password => @user.password}
      end

      it "should sign the user in" do
        post :create, :session => @attr
        controller.current_user.should == @user
        controller.should be_signed_in
      end

      it "should redirect to user show page" do
        post :create, :session => @attr
        response.should redirect_to(user_path(@user))
      end

    end

    describe "failure" do

      before(:each) do
        @attr = {:email => "" , :password => ""}
      end

      it "should render the 'new' page " do
        post :create, :session => @attr
        response.should render_template('new')
      end

      it "should render the right title" do
        post :create, :session => @attr
        response.should have_selector('title', :content => "SignIn")
      end

      it "should have an error message" do
        post :create, :session => @attr
        flash.now[:error].should =~ /invalid/i
      end

    end
  end

  describe "Delete 'destroy'" do
    it "should sign a user out " do
      test_sign_in(Factory(:user))
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to(root_path)
    end
  end

end

