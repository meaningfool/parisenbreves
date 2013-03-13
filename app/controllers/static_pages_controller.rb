require 'will_paginate/array'

class StaticPagesController < ApplicationController

	def home
		carousel_features_number = 10
		featured_breves = Breve.where("status='published'").order("random()").limit(carousel_features_number+8)
		@carousel_features = featured_breves.first(carousel_features_number)
		@secondary_features = featured_breves.last(8)
	end

	def contribute
	end
end
