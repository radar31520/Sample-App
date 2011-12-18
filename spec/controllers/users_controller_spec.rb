require 'spec_helper'

describe UsersController do

  render_views

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

