class UsersController < ApplicationController

	before_filter :admin_user, only: [:index, :edit, :update, :destroy]

	def index
		@user = User.new
		@users = User.paginate(page: params[:page])	
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

		def admin_user
			unless admin?
				not_found 
			end
		end
end
