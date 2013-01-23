require 'spec_helper'

describe 'Authentication' do

	subject {page}

	describe "signin page" do
	    before { visit signin_path }

		describe "with invalid information" do
			before { click_button "Sign in" }

			it { should have_selector('div.alert.alert-error', text: 'Invalid') }

			describe "after visiting another page" do
		        before { click_link "Home" }
		        it { should_not have_selector('div.alert.alert-error') }
	      	end
		end

		describe "with valid information" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				fill_in "Email",    with: user.email
				fill_in "Password", with: user.password
				click_button "Sign in"
			end

			it { should have_link('Profile', href: user_path(user)) }
			it { should have_link('Sign out', href: signout_path) }
			it { should_not have_link('Sign in', href: signin_path) }

			describe "followed by signout" do
        		before { click_link "Sign out" }
        		it { should have_link('Sign in') }
      		end
		end
	end

	describe "authorization" do
		describe "Non signed in users" do
			let(:user) { FactoryGirl.create(:user) }
			let(:breve) { FactoryGirl.create(:breve) }

			describe "cannot access the breve edit page" do
				before { visit edit_breve_path(breve) }
				it { expect(current_path).to eql(signin_path)}
			end

			describe "friendly forwarding when trying to access a protected page" do

				before do
					visit edit_breve_path(breve)
					fill_in "Email",    with: user.email
					fill_in "Password", with: user.password
					click_button "Sign in"
				end

				describe "after signing in" do

					it "should render the desired protected page" do
						expect(current_path).to eql(edit_breve_path(breve))
					end
				end	
			end
		end
	end
end