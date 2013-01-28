require 'spec_helper'

describe "User pages" do

	subject { page }

	describe "Signup page" do

		describe "The structure of the page" do
			before do 
				@user = User.new
				visit new_user_path(@user)
			end
			it { should have_button('submit')}
		end

		describe "Submission with valid input" do
			before do 
				@new_user = FactoryGirl.build(:user)
				visit new_user_path(@new_user)
				fill_in 'user_name', with: @new_user.name
				fill_in 'user_email', with: @new_user.email
				fill_in 'user_password', with: @new_user.password
				fill_in 'user_password_confirmation', with: @new_user.password_confirmation
			end

			it "increases the number of users by 1" do
				expect {click_button "submit"}.to change(User, :count).by(1)
			end

			it "redirects to the show page of the user" do
				click_button "submit"
				expect(current_path).to eql(user_path(User.last))
			end

			describe "saves the information" do
				before do
					click_button "submit"
				end
				it { expect(User.last.email).to eql(@new_user.email) }
				it { should have_link('sign_out') }
			end
		end

		describe "Submission using an invalid entry" do
			before do
				@new_user_1 = FactoryGirl.create(:user)
				@new_user_2 = FactoryGirl.build(:user, name: @new_user_1.name)
				visit new_user_path(@new_user_2)
				fill_in 'user_name', with: @new_user_2.name
				fill_in 'user_email', with: @new_user_2.email
				fill_in 'user_password', with: @new_user_2.password
				fill_in 'user_password_confirmation', with: @new_user_2.password_confirmation
			end

			it "leaves the number of users unchanged" do
				expect {click_button "submit"}.not_to change(User, :count)
			end

			describe "displays the field values entered before submitting" do
				before do 
					click_button "submit" 
				end
				it { should have_field('user_name', with: @new_user_2.name)}
				it { should have_field('user_email', with: @new_user_2.email)}
				it { should have_field('user_password', with: @new_user_2.password)}
				it { should have_field('user_password_confirmation', with: @new_user_2.password_confirmation)}
			end
		end
	end

	describe "List page" do

		describe "Non admin users" do
			it "redirects non signed in users to the 404 page" do
				@user = FactoryGirl.create(:user)
				expect {visit users_path}.to raise_error(ActionController::RoutingError)
			end

			it "redirects signed in but non admin users to the 404 page" do
				@user = FactoryGirl.create(:user)
				sign_in @user
				expect {visit users_path}.to raise_error(ActionController::RoutingError)
			end
		end

		describe "Admin users" do

			#let(:admin) {FactoryGirl.create(:admin, name: "moi")}
			before do
				@admin = FactoryGirl.create(:admin, name: "moi")
				@bob = FactoryGirl.create(:user, name: "bob")
				sign_in @admin
				visit users_path
			end 

			describe "pagination" do
				before(:all) { 30.times {FactoryGirl.create(:user)} }
				after(:all) { User.delete_all }

				it { should have_selector('div.pagination') }
				it "should list each user" do
					User.paginate(page: 1).each do |u|
						page.should have_selector('li', text: u.name)
					end
				end
			end

			describe "Clicking on the user name displays the user show page" do
				before do
					click_link("show_user_#{@bob.id}")
				end
				it "displays the user show page" do
					expect(current_path).to eql(user_path(@bob))
				end
			end

			it "does not display a delete link for the admin" do
				expect(element_not_found?("delete_user_#{@admin.id}")).to be_true
			end

			describe "Clicking the delete link deletes the user and renders the users list page" do
				it "decreases by 1 the number of users" do
					expect{click_link("delete_user_#{@bob.id}")}.to change(User, :count).by(-1)
				end
				it "displays the users list page" do
					click_link("delete_user_#{@bob.id}")
					expect(current_path).to eql(users_path)
				end
				it "deleted the user" do
					click_link("delete_user_#{@bob.id}")
					expect(User.exists?(@bob)).to be_false
				end
			end

		end
	end

	describe "Show page" do

		describe "Non admin" do
			it "redirects non signed in users to the 404 page" do
				@user = FactoryGirl.create(:user)
				expect {visit users_path}.to raise_error(ActionController::RoutingError)
			end

			it "redirects signed in but non admin users to the 404 page" do
				@user = FactoryGirl.create(:user)
				sign_in @user
				expect {visit users_path}.to raise_error(ActionController::RoutingError)
			end
		end

		describe "Signed in users" do

			let(:user) {FactoryGirl.create(:admin)}
			before do
				@bob = FactoryGirl.create(:user, name: "bob")
				sign_in user
				visit users_path
			end 
			it "decreases by 1 the number of users" do
				expect{click_link("delete_user_#{@bob.id}")}.to change(User, :count).by(-1)
			end
			it "displays the users list page" do
				click_link("delete_user_#{@bob.id}")
				expect(current_path).to eql(users_path)
			end
			it "deleted the user" do
				click_link("delete_user_#{@bob.id}")
				expect(User.exists?(@bob)).to be_false
			end
		end
	end

end