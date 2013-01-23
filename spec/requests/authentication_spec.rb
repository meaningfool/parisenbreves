require 'spec_helper'

describe "Authentication" do
	describe "authorization" do

		describe "for non signed in users" do
			let(:user) { FactoryGirl.create(:user) }
			let(:breve) { FactoryGirl.create(:breve) }

			describe "in the Breves controller" do

				describe "submitting to the update action" do
					before { put breve_path(breve) }
					specify { response.should redirect_to(signin_path)}
				end

				describe "submitting to the destroy action" do
					before { delete breve_path(breve) }
					specify { response.should redirect_to(signin_path)}
				end
			end

			describe "in the Users controller" do

				describe "submitting to the destroy action" do
					before { delete user_path(user) }
					specify { response.should redirect_to(signin_path)}
				end
			end
		end
	end
end
