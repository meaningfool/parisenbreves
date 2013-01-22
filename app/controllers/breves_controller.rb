class BrevesController < ApplicationController
	def index
		@breve = Breve.new
		@breves = Breve.all	
	end

	def create 
		@breve = Breve.new params[:breve]
		if @breve.save
			redirect_to @breve
		else
			render 'new'
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
end
