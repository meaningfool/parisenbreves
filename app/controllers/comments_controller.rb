class CommentsController < ApplicationController
	load_and_authorize_resource

	def create
		@comment = Comment.new 
		@comment.breve_id = params[:breve_id]
		@comment.user = current_user
		@comment.content = params[:comment][:content]
		session[:active_tab] = "comment_tab"
		session[:active_pane] = "comment_pane"
		if @comment.save
			flash[:success] = "Commentaire enregistre"
		else
			flash[:error] = "Les commentaires sont limites a 400 caracteres"
		end
		redirect_to @comment.breve
	end

	def destroy

	end

end