# encoding: UTF-8
class UsersController < ApplicationController
	load_and_authorize_resource

	def index
		@user = User.new
		@users = User.paginate(page: params[:page])	
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new user_params
		@user.role ||= "standard"
		
		if @user.save
			@user.reload
			sign_in @user
  			flash[:success] = "Bienvenue sur Paris en brèves"
			redirect_to @user
		else
			flash.now[:error] = 'Formulaire incomplet'
			render 'new'
		end
	end

	def update
		@user = User.new user_params
		@user.role ||= "standard"

		if @user.save
			@user.reload
			sign_in @user
  			flash[:success] = "Modifications enregistrées"
			redirect_to @user
		else
			flash.now[:error] = 'Formulaire incomplet'
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

		def user_params
			allowed_attributes = [:email, :name, :password, :password_confirmation]
			if signed_in? && admin?
				allowed_attributes += [:role]
			end
			params.require(:user).permit(*allowed_attributes)
		end
end
