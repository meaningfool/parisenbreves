class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

	def not_found
		raise ActionController::RoutingError.new('Not Found')
	end

	def authenticate
		redirect_to signin_path unless (signed_in? && admin?)
	end

end
