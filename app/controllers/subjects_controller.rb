# encoding: UTF-8

class SubjectsController < ApplicationController
	load_and_authorize_resource
	before_filter do
		@subject_count = Subject.where("status='active'").count
		@draft_count = Breve.where("status='draft'").count
		@published_count = Breve.where("status='published'").count
	end

	def index
		@content = Subject.where("status='active'").order("updated_at DESC").paginate(page: params[:page])
		render template: 'shared/_content_list', layout: 'contents'
	end

	def new
		render layout: 'contents'
	end

	def create 
		@subject = Subject.new subject_params
		if @subject.save
			redirect_to @subject
		else
			render :action => :new
		end
	end

	def show
		@view_pane = "content"
		subject = Subject.find_by_id params[:id]
		@subjects = (Subject.where("status='active'").order("random()")-[subject])
		render layout: 'contents'
	end

	def edit
		render layout: 'contents'
	end

	def update
		if @subject.update_attributes subject_params
			if URI(request.referer).path == edit_subject_path(@subject)
				redirect_to @subject, notice: "Modifications enregistrées"
			else
				redirect_to subjects_path, notice: "Sujet marqué comme traité"
			end
		else
			if URI(request.referer).path == edit_subject_path(@subject)
				render 'edit', notice: "Les modifications ne sont pas valides"
			else
				redirect_to subjects_path, notice: "Le sujet n'a pas été marqué comme traité"
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

	private
		def subject_params
			params.require(:subject).permit(:title, :description, :status)
		end
end