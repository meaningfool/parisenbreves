class BrevesController < ApplicationController
	load_and_authorize_resource
	#before_filter :signed_in_user, only: [:edit, :update, :destroy]

	def index
		@breve = Breve.new
		@breves = Breve.all	
	end

	def published	
		@published_count = Breve.where("status='published'").count
		@published = Breve.where("status='published'").order("updated_at DESC").paginate(page: params[:page])
		@content_type = 'published'
		render layout: 'contents'
	end

	def drafts
		@published_count = Breve.where("status='published'").count
		@draft = Breve.where("status='draft'").order("updated_at DESC").paginate(page: params[:page])
		@content_type = 'draft'
		render layout: 'contents'
	end

	def create 
		@breve = Breve.new params[:breve]
		if !(current_user.role == "editor" || current_user.role == "admin")
			@breve.status = "draft"
		end
		if @breve.save
			redirect_to @breve
		else
			render :action => :new
		end
	end

	def show
		@published_count = Breve.where("status='published'").count
		@breve = Breve.find params[:id]
		@content_type = @breve.status
		render layout: 'contents'
	end

	def edit
		@published_count = Breve.where("status='published'").count
		@breve = Breve.find params[:id]
		@content_type = @breve.status
		render layout: 'contents'
	end

	def new
		@published_count = Breve.where("status='published'").count
		@breve = Breve.new
		@content_type = @breve.status
		render layout: 'contents'
	end

	def update
		@breve = Breve.find params[:id]
		if current_user.role == nil || current_user.role == "guest" || current_user.role == "standard"
			params[:breve][:status] = @breve.status
		end
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
