class UsersController < ApplicationController
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
		@breve = Breve.find params[:id]
		if @breve.delete
			redirect_to :breves
		else
			render 'index'
		end
	end
end
