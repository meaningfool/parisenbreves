class UsersController < ApplicationController

	before_filter :signed_in_user, only: [:edit, :update, :destroy]

	def index
		@user = User.new
		@users = User.all	
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new params[:user]
		if @user.save
			sign_in @user
  			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def show
		@user = User.find params[:id]
	end

	def destroy
		@user = User.find params[:id]
		if @user.delete
			redirect_to :users
		else
			render 'index'
		end
	end
	
	private

		def signed_in_user
			unless signed_in?
				store_location
				redirect_to signin_url, notice: "Please sign in."
			end
		end
end
