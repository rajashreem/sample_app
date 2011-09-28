class UsersController < ApplicationController
  def new
	@title = "sign_up"
  end
	
  def show 
	@user = User.find(params[:id])
  end

end
