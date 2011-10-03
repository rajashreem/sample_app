require 'spec_helper'

describe User do
	before(:each) do
		@attr = {:name => "abc", :email => "abc@xyz.com",
				:password => "rajashree", 
				:password_confirmation => "rajashree"}
	end

	it "should create valid record properly" do
		User.create!(@attr)
	end

	it "should not create user with blank name" do
		u = User.new(@attr.merge(:name => ""))
		u.should_not be_valid
	end

	it "should not create user with blank email id" do
		u = User.new(@attr.merge(:email => ""))
		u.should_not be_valid
	end

	it "shouldn't have name longer than 50 characters" do
		nm = "a" * 51
		user = User.new(@attr.merge(:name => nm))
		user.should_not be_valid
	end

	it "should accept valid email addresses" do 
		addrs = %w[abc@gmail.com ABC_SDK@gmail.com abc.xyz@gmail.com]
		addrs.each do |addr|
			u = User.new(@attr.merge(:email => addr))
			u.should be_valid
		end
	end


	it "should not accept invalid email addresses" do 
		addrs = %w[abc@gmail,com ABC_SDK.gmail.com abc.xyz@gmail.]
		addrs.each do |addr|
			u = User.new(@attr.merge(:email => addr))
			u.should_not be_valid
		end
	end


	it "should not accept duplicate email addresses" do
		User.create!(@attr)
		u = User.new(@attr)
		u.should_not be_valid
	end	

	it "should not accept duplicate email addresses with cases changed" do
		mail = @attr[:email].upcase
		User.create!(@attr.merge(:email => mail))
		user = User.new(@attr)
		user.should_not be_valid
	end


	describe "password validations" do
	it "should require password" do
		u = User.new(@attr.merge(:password => "", :password_confirmation => ""))
		u.should_not be_valid
	end

	it "should require same password confirmation" do
		u = User.new(@attr.merge(:password_confirmation => "des"))
		u.should_not be_valid
	end

	it "should reject short passwords" do
		a = "a"*5;
		u = User.new(@attr.merge(:password => a, :password_confirmation => a))
		u.should_not be_valid
	end

	it "should reject long passwords" do
		a = "a" * 40
		u = User.new(@attr.merge(:password => a, :password_confirmation => a))
		u.should_not be_valid
	end
	end


	describe "password encryption" do
	before(:each) do
		@user = User.create!(@attr)
	end

	it "should have encrypted password" do
		@user.should respond_to(:encrypted_password)
	end

	it "should set the encrypted password" do
		@user.encrypted_password.should_not be_blank
	end

	it "should be true for same password" do
		@user.has_password?(@attr[:password]).should be_true
	end

	it "should false if passwords do not match" do
		@user.has_password?("das").should be_false
	end  
	end
	
end
