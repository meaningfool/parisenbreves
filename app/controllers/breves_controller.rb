class BrevesController < ApplicationController
	load_and_authorize_resource
	#before_filter :signed_in_user, only: [:edit, :update, :destroy]

	def index
		@breve = Breve.new
		@breves = Breve.all	
	end

	def create 
		@breve = Breve.new params[:breve]
		if @breve.save
			redirect_to @breve
		else
			render :action => :new
		end
	end

	def show
		@breve = Breve.find params[:id]
	end

	def edit
		@breve = Breve.find params[:id]
	end

	def new
		@breve = Breve.new
	end

	def update
		@breve = Breve.find params[:id]
		if @breve.update_attributes params[:breve]
			redirect_to @breve
		else
			render 'edit'
		end
	end

	def destroy
		@breve = Breve.find params[:id]
		if @breve.delete
			redirect_to :breves
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
