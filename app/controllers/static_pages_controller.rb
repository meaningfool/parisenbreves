require 'will_paginate/array'

class StaticPagesController < ApplicationController
	def home
		@update_ordered = Breve.order("updated_at DESC").paginate(page: params[:page])
		@reference_point = [48.85, 2.35]
		ordered = Breve.find_near(@reference_point,10000)
		@location_ordered = Breve.find_near(@reference_point,10000).paginate(page: params[:page])
		#binding.pry
	end

	def content
	end

	def contribute
	end
end
