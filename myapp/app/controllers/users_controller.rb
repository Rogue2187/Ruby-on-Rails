class UsersController < ApplicationController

	before_action :authenticate_user!, :only => [:show, :index,:edit, :update]

	def show
		@user = User.find(params[:id])
	end

	def index
		@users = User.all
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.update(params.require(:user).permit(:first_name,:family_name,:self_introduction))
	end

end
