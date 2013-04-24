class SearchController < ActionController::Base

	def index
		@center = Geocoder.coordinates params[:location]
		gon.center = @center
		@content = Breve.find_near(@center, 10000, "published")
		gon.searchResults = @content
		render template: 'search/_search_results', layout: 'search'
	end

end