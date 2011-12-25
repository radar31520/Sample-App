require 'spec_helper'

describe UsersController do

  render_views

  describe "GET 'show'" do

    before(:each) do
      @user = Factory(:user)
    end

    it "returns http success" do
      get 'show', :id => @user
      response.should be_success
    end

    it "should find the right user" do
      get 'show', :id => @user
      assigns(:user).should == @user
    end

    it "should have the right title" do
      get 'show', :id => @user
      response.should have_selector("title", :content => "Ruby on Rails Tutorial Sample App | #{@user.name}")
    end

    it "should have the user's name in the h1 tag" do
      get 'show', :id => @user
      response.should have_selector("h1", :content => "#{@user.name}")
    end

    it "should have a profile image" do
      get 'show', :id => @user
      response.should have_selector("h1>img", :class => "gravatar")
    end

    it "should have the right url" do
      get 'show', :id => @user
      response.should have_selector("td>a", :content => user_path(@user), :href => user_path(@user))
    end

  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Ruby on Rails Tutorial Sample App | SignUp")
    end
    it "should have a non-blank body" do
      get 'new'
      response.body.should_not =~ /<body>\s*<\/body>/
    end
  end

end

