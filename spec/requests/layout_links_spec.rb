require 'spec_helper'

describe "LayoutLinks" do

  it "should have a home page at '/' " do
    get '/'
    response.should have_selector('title', :content => "Home")
  end

  it "should have a contact page at '/contact' " do
    get '/contact'
    response.should have_selector('title', :content => "Contact")
  end

   it "should have a contact page at '/about' " do
    get '/about'
    response.should have_selector('title', :content => "About")
  end

  it "should have a contact page at '/help' " do
    get '/help'
    response.should have_selector('title', :content => "Help")
  end

   it "should have a contact page at '/SignUp' " do
    get '/signup'
    response.should have_selector('title', :content => "SignUp")
  end

  it "should have a contact page at '/SignIn' " do
    get '/signin'
    response.should have_selector('title', :content => "SignIn")
  end

  #it "should have a contact page at '/SignOut' " do
   # get '/signout'
  #  response.should have_selector('title', :content => "SignOut")
 # end

  it "should have right links on the layout" do
    visit root_path
    response.should have_selector('title', :content => "Home")
    click_link "About"
    response.should have_selector('title', :content => "About")
    click_link "Contact"
    response.should have_selector('title', :content => "Contact")
    click_link "Home"
    response.should have_selector('title', :content => "Home")
    click_link "Sign up now!"
    response.should have_selector('title', :content => "SignUp")
    click_link "Sample App"
    response.should have_selector('title', :content => "Home")
  end
end

