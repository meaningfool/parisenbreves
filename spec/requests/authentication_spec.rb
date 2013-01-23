require 'spec_helper'
include Rack::Test

describe "Authentication" do
	describe "authorization" do

		describe "in the Breves controller" do

			describe "for non signed in users" do
				let(:breve) { FactoryGirl.create(:breve) }

				describe "submitting to the update action" do
					before { put breve_path(breve) }
					specify { response.should redirect_to(signin_path)}
				end

				describe "submitting to the destroy action" do
					before { delete breve_path(breve) }
					specify { response.should redirect_to(signin_path)}
				end
			end
=begin
			describe "for the signed in users" do
				let(:breve) { FactoryGirl.create(:breve) }
				before do 
					user = FactoryGirl.create(:user)
					@env ||= {}
				    name =  user.email
				    pw = user.password
				    @env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(name,pw)
				end

				describe "submitting to the update action" do
					before { put breve_path(breve) }
					specify { response.should be_success}
				end

				describe "submitting to the destroy action" do
					before { delete breve_path(breve) }
					specify { response.should be_success}
				end
			end
=end
		end

		describe "in the Users controller" do

			describe "for the non admin users" do
				let(:user) { FactoryGirl.create(:user) }

				describe "accessing the index page" do
					specify do
						lambda {get users_path}.should raise_error(ActionController::RoutingError)
					end
				end

				describe "submitting to the destroy action" do
					specify do
						lambda {delete user_path(user)}.should raise_error(ActionController::RoutingError)
					end
				end
			end


		end
	end
end
