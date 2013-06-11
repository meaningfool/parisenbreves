require 'will_paginate/array'

class StaticPagesController < ApplicationController

	def home
		carousel_features_number = 15
		featured_breves = Breve.where("status='published' AND photo_file_name IS NOT NULL").order("random()").limit(carousel_features_number)
		#featured_breves = Breve.where("status='published'").order("updated_at DESC").limit(carousel_features_number+8)
		#binding.pry
		@carousel_features = featured_breves
	end

	def contribute
	end

	def search
		@search_type = params[:search_type] ? params[:search_type] : 'location'
		@location = (@search_type == 'location' && params[:search_query]) ? params[:search_query] : 'place de la Concorde'
		@text = (@search_type== 'text' && params[:search_query]) ? params[:search_query] : 'Louis'
		@content_type = params[:content_type] ? params[:content_type] : 'published'
		@reference_point = Geocoder.coordinates @location
		if @search_type == 'location'
			@content = Breve.find_near(@reference_point, 10000, @content_type)
		else
			@content = Breve.where("status='#{@content_type}'")
		end
		
		render template: 'search/_search_results', layout: 'search'
	end

	def map
		@published = Breve.where("status='published'")
		@published.map{|k,v| k.photo_file_name = k.photo.url(:thumb) }
		gon.root = root_url
		gon.published = @published
		gon.draft = Breve.where("status='draft'")
	end
end
