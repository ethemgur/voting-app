class ProfilesController < ApplicationController
  def show
  	@user = User.find_by(:username => params[:username])
  	@votes = Vote.where(:user_id => @user.id)
  end
end
