module AuthHelper

	def normal_login
	  user = "test"
	  pw = "test_pw"
	  request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
	end
end