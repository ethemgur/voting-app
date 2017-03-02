class ProfilesController < ApplicationController
  def show
  	@user = User.find(params[:id])
  	@votes = Vote.where(:user_id => @user.id)
  end
end
