class SubjectsController < ApplicationController
	load_and_authorize_resource
	before_filter do
		@published_count = Breve.where("status='published'").count
	end

	def index
		@content = Subject.where("status='active'").order("updated_at DESC").paginate(page: params[:page])
		render template: 'shared/_content_list', layout: 'contents'
	end

	def new
		render layout: 'contents'
	end

	def show
		@view_pane = "content"
		subject = Subject.find_by_id params[:id]
		@subjects = (Subject.where("status='active'").order("updated_at DESC")-[subject]).paginate(page: params[:page])
		render layout: 'contents'
	end

	def edit
		render layout: 'contents'
	end

	def update
		if @subject.update_attributes params[:subject]
			if URI(request.referer).path == edit_subject_path(@subject)
				redirect_to @subject, notice: "Modifications enregistrees"
			else
				redirect_to subjects_path, notice: "Sujet marque comme traite"
			end
		else
			if URI(request.referer).path == edit_subject_path(@subject)
				render 'edit', notice: "Les modifications ne sont pas valides"
			else
				redirect_to subjects_path, notice: "Le sujet non marque comme traite"
			end
		end
	end

	def destroy
		if @subject.delete
			redirect_to :subjects
		else
			render 'index'
		end
	end

end