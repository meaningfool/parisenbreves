require 'spec_helper'

describe "User pages" do

	subject { page }

	describe "Signup page" do

		describe "The structure of the page" do
			before do 
				@user = User.new
				visit new_user_path(@user)
			end
			it { should have_field('user_name') }
			it { should have_field('user_email') }
			it { should have_field('user_password')}
			it { should have_field('user_password_confirmation')}
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

			describe "information has been savec and is displayed on the show page" do
				before do
					click_button "submit"
				end
				it { should have_selector('.user_name', text: @new_user.name)}
				it { should have_selector('.user_email', text: @new_user.email)}
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

			#it "renders the new page" do
			#	click_button "submit"
			#	expect(current_path).to eql(new_user_path(@new_user_2))
			#end

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
		before do
			@user = FactoryGirl.create(:user)
			visit users_path
			#save_and_open_page
		end

		describe "The page displays the users and delete link" do
			it { should have_selector('.user_name', :text => @user.name) }

			it "has links with the appropriate ids for show and delete" do
				expect { find("#show_user_#{@user.id}").not_to be_nil}
				expect { find("#delete_user_#{@user.id}").not_to be_nil}
			end
			it "has actually links towards the show and delete actions" do
				expect { find("#show_user_#{@user.id}")[:href].to eql(breve_url(@user)) }
				expect { find("#delete_user_#{@user.id}")[:method].to eql("delete") }
			end
		end

		describe "Clicking on the breve title displays the breve show page" do
			before do
				click_link("show_user_#{@user.id}")
			end
			it "displays the user show page" do
				expect(current_path).to eql(user_path(@user))
			end
		end
=begin
		describe "Clicking the delete link deletes the user and renders the users list page" do
			it "decreases by 1 the number of users" do
				expect{click_link("delete_user_#{@user.id}")}.to change(User, :count).by(-1)
			end
			it "displays the users list page" do
				expect(current_path).to eql(users_path)
			end
			it "does not display the deleted user" do
				expect { find("#show_user_#{@user.id}").to be_nil}
			end
		end
=end

	end

end