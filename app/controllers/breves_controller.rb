class BrevesController < ApplicationController
	load_and_authorize_resource
	before_filter do
		@subject_count = Subject.where("status='active'").count
		@draft_count = Breve.where("status='draft'").count
		@published_count = Breve.where("status='published'").count
	end

	def index
		redirect_to :published
	end

	def published	
		@content = Breve.where("status='published'").order("updated_at DESC").paginate(page: params[:page])
		render template: 'shared/_content_list', layout: 'contents'
	end

	def drafts
		@content = Breve.where("status='draft'").order("updated_at DESC").paginate(page: params[:page])
		render template: 'shared/_content_list', layout: 'contents'
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
		@tab_mode = session[:tab_mode]
		session[:tab_mode] = nil
		@tab_mode ||= "content"
		if request.referer.try {|p| p.include? "versions"} && Version.find_by_id(URI.parse(request.referer).path.split('/').last).reify == @breve
			@tab_mode = "history"
		end
		@reference_point = [@breve.latitude, @breve.longitude]
		@closeby = @breve.find_near(10000)
		render layout: 'contents'
	end

	def edit
		render layout: 'contents'
	end

	def new
		render layout: 'contents'
	end

	def update
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
