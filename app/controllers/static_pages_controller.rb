require 'will_paginate/array'

class StaticPagesController < ApplicationController

	def home
		@featured_breves = Breve.where("status='published'").order("updated_at DESC").limit(5)
		@last_published = Breve.where("status='published'").order("updated_at DESC").offset(5).limit(8)
		#@reference_point = [48.85, 2.35]
		#@location_ordered = Breve.find_near(@reference_point,10000).paginate(page: params[:page])
		#binding.pry
	end

	def contribute
	end
end
