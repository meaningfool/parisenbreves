class VersionsController < ApplicationController
	load_and_authorize_resource

	def show
		@published_count = Breve.where("status='published'").count
		@breve = Version.find(params[:id]).reify
		@content_type = @breve.status
		@view_pane = "history"
		@reference_point = [@breve.latitude, @breve.longitude]
		@closeby = @breve.find_near(10000).paginate(page: params[:page])
		back_link = view_context.link_to "Retour a la version courante", breve_path(@breve)
		flash.now[:error] = "Il ne s'agit pas de la version courante de la breve ! <div class='back_link'>#{back_link}</div>"
		render template: 'breves/show', layout: 'contents'
	end

	def revert
		@version = Version.find params[:id]
		@version.reify.save!
		redirect_to :back, notice: "Retablissement de la version en date du #{@version.created_at} reussi"
	end
end