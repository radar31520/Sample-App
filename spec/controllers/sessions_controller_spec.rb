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

end

