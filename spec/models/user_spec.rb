require 'spec_helper'


# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#


describe User do

  before(:each) do
    @test_user = {  :name => "User",
                    :email => "user@example.com",
                    :password => "password",
                    :password_confirmation => "password"}
  end

  it "should create a new instance given a valid attribute" do
    User.create!(@test_user)
  end

  it "should require a name" do
    no_name_user = User.new(@test_user.merge(:name => ""))
    #calls valid? on no_name_user
    no_name_user.should_not be_valid
  end


  it "should require a email address" do
    no_email_user = User.new(@test_user.merge(:email => ""))
    no_email_user.should_not be_valid
  end

  it "should reject names that are too long" do
    long_name = "a" * 51;
    long_name_user = User.new(@test_user.merge(:name => long_name))
    long_name_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user_foo@foo.com The_User@foo.bar.org me_last_@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new(@test_user.merge(:email => address))
      valid_email_user.should be_valid
    end
  end

  it "should not accept invalid email addresses" do
    addresses = %w[user_foo@org The_User_foo.org jackman]
    addresses.each do |address|
      invalid_email_user = User.new(@test_user.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email address " do
    User.create!(@test_user)
    user_with_duplicate_email = User.new(@test_user.merge(:name => "Duane"))
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject duplicate email address with different cases" do
    User.create!(@test_user)
    user_with_duplicate_email = User.new(@test_user.merge(:email => @test_user[:email].upcase))
    user_with_duplicate_email.should_not be_valid
  end

  describe "passwords" do

    before(:each) do
      @user = User.new(@test_user)
    end

    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end

  end

  describe "password_validations" do

    it "should require a password" do
      User.new(@test_user.merge(:password => "", :password_confirmation =>"")).should_not be_valid
    end

    it "should require a matching password confirmation" do
      User.new(@test_user.merge(:password_confirmation =>"invalid_confirmation")).should_not be_valid
    end

    it "should reject a short password " do
      short = "a" * 5
      User.new(@test_user.merge(:password =>short, :password_confirmation => short)).should_not be_valid
    end

    it "should reject a long password" do
      long = "a" * 41
      User.new(@test_user.merge(:password =>long, :password_confirmation => long)).should_not be_valid
    end

  end

  describe "password encryption" do

      before(:each) do
        @user = User.create!(@test_user)
      end

      it "should have an encrypted password attribute" do
        @user.should respond_to(:encrypted_password)
      end

      it "should set an encrypted password attribute" do
        @user.encrypted_password.should_not be_blank
      end

      it "it should have a salt" do
        @user.should respond_to(:salt)
      end

     describe "has_password" do

        it "it should exist" do
          @user.should respond_to(:has_password?)
        end

        it "should return true if the passwords match" do
          @user.has_password?(@test_user[:password]).should be_true
        end

        it "should return false if the passwords do not match" do
          @user.has_password?("invalid_password").should be_false
        end
      end

    describe "authenticate method" do

      it "it should exist" do
        User.should respond_to(:authenticate)
      end


      it "should return nil on email/password mismatch" do
        User.authenticate(@test_user[:email], "wrongpass").should be_nil
      end

      it "should return nil on email with not user" do
        User.authenticate("wrongpass@email.com", @test_user[:password]).should be_nil
      end

      it "should return actual user" do
        User.authenticate(@test_user[:email], @test_user[:password]).should == @user
      end
    end
  end
end

