# encoding: UTF-8
class CommentsController < ApplicationController
	load_and_authorize_resource

	def create
		@comment = Comment.new 
		@comment.breve_id = params[:breve_id]
		@comment.user = current_user
		@comment.content = params[:comment][:content]
		if @comment.save
			flash[:success] = "Commentaire enregistré"
		else
			flash[:error] = "Les commentaires sont limités a 400 caractères"
		end
		session[:tab_mode] = "comment"
		redirect_to @comment.breve
	end

	def destroy
		if @comment.delete
			flash[:success] = "Le commentaire a été supprimé"
		else
			flash[:error] = "Le commentaire n'a pu être supprimé"
		end
		session[:tab_mode] = "comment"
		redirect_to @comment.breve
	end

end