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

end

