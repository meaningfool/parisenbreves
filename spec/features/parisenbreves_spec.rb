#!/usr/bin/env ruby -w
# encoding: UTF-8

require 'spec_helper'

describe "Breve pages" do
	subject { page }

	describe "Breve show page" do
		
		describe "For non logged in users" do
			before do 
				@breve = FactoryGirl.create(:breve)
				visit breve_path(@breve)
			end

			it { should have_link(@breve.source_name, :href => @breve.source_URL)}
			it { should have_selector('.latitude', :text => @breve.latitude.to_s)}
			it { should have_selector('.longitude', :text => @breve.longitude.to_s)}

			it "does not have links to the edit and delet actions" do
				expect(element_not_found?("edit_breve_#{@breve.id}")).to be_true
				expect(element_not_found?("delete_breve_#{@breve.id}")).to be_true
			end
		end

		describe "For logged in users" do
			let(:user) {FactoryGirl.create(:user)}
			before do
				@breve = FactoryGirl.create(:breve)
				sign_in user
				visit breve_path(@breve)
			end 
			it "has links to the edit and delete actions" do
				expect(find_by_id("edit_breve_#{@breve.id}")[:href]).to eql(edit_breve_path(@breve))
				expect(find_by_id("delete_breve_#{@breve.id}")[:'data-method']).to eql("delete")
			end
		end

	end

	describe "Breve new page" do

		before do
			@new_breve = Breve.new
			visit new_breve_path(@new_breve)
		end

		describe "The structure of the page" do 
			it {should have_field('breve_latitude')}
			it {should have_field('breve_longitude')}
			it {should have_button('submit')}
		end

		describe "Submission with valid input" do
			before do
				@new_breve = FactoryGirl.build(:breve)
				fill_in 'breve_title', with: @new_breve.title
				fill_in 'breve_location', with: @new_breve.location
				fill_in 'breve_description', with: @new_breve.description
				fill_in 'breve_source_name', with: @new_breve.source_name
				fill_in 'breve_source_URL', with: @new_breve.source_URL
				fill_in 'breve_latitude', with: @new_breve.latitude
				fill_in 'breve_longitude', with: @new_breve.longitude
				
			end

			it "increases the number of breves by 1" do
				expect {click_button "submit"}.to change(Breve, :count).by(1)
			end

			it "redirects to the show page of the breve created" do
				click_button "submit"
				expect(current_path).to eql(breve_path(Breve.last))
			end

			it "properly saves the data" do	
				click_button "submit"
				expect(Breve.last.title).to eql(@new_breve.title)	
			end
		end

		describe "Submission with invalid input" do
			before do
				@new_breve = FactoryGirl.build(:breve, title: " ")
				fill_in 'breve_title', with: @new_breve.title
				fill_in 'breve_location', with: @new_breve.location
				fill_in 'breve_description', with: @new_breve.description
				fill_in 'breve_source_name', with: @new_breve.source_name
				fill_in 'breve_source_URL', with: @new_breve.source_URL
				fill_in 'breve_latitude', with: @new_breve.latitude
				fill_in 'breve_longitude', with: @new_breve.longitude
			end
			
			it "leaves the number of breves unchanged" do
				expect{ click_button "submit"}.not_to change(Breve, :count)
			end

			describe "The form should display the field values entered before submitting" do
				before do
					click_button "submit"
				end
				it { should have_field('breve_title', :with => @new_breve.title) }
				it { should have_field('breve_location', :with => @new_breve.location)}
				it { should have_field('breve_description'), :with => @new_breve.description}

				it { should have_field('breve_source_name', :with => @new_breve.source_name)}
				it { should have_field('breve_source_URL', :with => @new_breve.source_URL)}
				it { should have_field('breve_latitude', :with => @new_breve.latitude.to_s)}
				it { should have_field('breve_longitude', :with => @new_breve.longitude.to_s)}
			end

			#it { should have_selector('.flash') }
		end
	end

	describe "Breve edit page" do

		describe "Non signed in users" do
			let(:user) {FactoryGirl.create(:user)}
			before do
				@edit_breve = FactoryGirl.create(:breve)
				visit edit_breve_path(@edit_breve)
			end

			it "displays the loggin page" do
				expect(current_path).to eql(signin_path)
			end
		end

		describe "Signed in users" do
			let(:user) {FactoryGirl.create(:user)}
			before do
				@edit_breve = FactoryGirl.create(:breve)
				sign_in user
				visit edit_breve_path(@edit_breve)
			end

			describe "The form should display the field values corresponding to the breve being edited" do
				it { should have_field('breve_title', :with => @edit_breve.title) }
				it { should have_field('breve_location', :with => @edit_breve.location)}
				it { should have_field('breve_description'), :with => @edit_breve.description}

				it { should have_field('breve_source_name', :with => @edit_breve.source_name)}
				it { should have_field('breve_source_URL', :with => @edit_breve.source_URL)}
				it { should have_field('breve_latitude', :with => @edit_breve.latitude.to_s)}
				it { should have_field('breve_longitude', :with => @edit_breve.longitude.to_s)}
			end

			describe "Submission with valid input" do
				before do
					@new_breve = FactoryGirl.build(:breve)
					fill_in 'breve_title', with: @new_breve.title
					fill_in 'breve_location', with: @new_breve.location
					fill_in 'breve_description', with: @new_breve.description
					fill_in 'breve_source_name', with: @new_breve.source_name
					fill_in 'breve_source_URL', with: @new_breve.source_URL
					fill_in 'breve_latitude', with: @new_breve.latitude
					fill_in 'breve_longitude', with: @new_breve.longitude		
				end

				it "does not change the number of breves" do
					expect {click_button "submit"}.not_to change(Breve, :count)
				end

				it "redirects to the show page of the breve created" do
					click_button "submit"
					expect(current_path).to eql(breve_path(@edit_breve))
				end

				describe "The breve information have been saved" do	
					before {click_button "submit"}
					it { @edit_breve.reload.title == @new_breve.title }
				end
			end

			describe "Submission with invalid input" do
				before do
					@edit_breve.title = " "
					fill_in 'breve_title', with: @edit_breve.title
				end
				
				it "leaves the number of breves unchanged" do
					expect{ click_button "submit"}.not_to change(Breve, :count)
				end

				describe "The form should display the field values entered before submitting" do
					before do
						click_button "submit"
					end
					it { should have_field('breve_title', :with => @edit_breve.title) }
					it { should have_field('breve_location', :with => @edit_breve.location)}
					it { should have_field('breve_description'), :with => @edit_breve.description}

					it { should have_field('breve_source_name', :with => @edit_breve.source_name)}
					it { should have_field('breve_source_URL', :with => @edit_breve.source_URL)}
					it { should have_field('breve_latitude', :with => @edit_breve.latitude.to_s)}
					it { should have_field('breve_longitude', :with => @edit_breve.longitude.to_s)}
				end

				#it { should have_selector('.flash') }
			end
		end
	end

	describe "Breve list page" do
		
		describe "Non signed in users" do
			before do
				@breve = FactoryGirl.create(:breve)
				visit breves_path
			end

			it { should have_selector('.title', :text => @breve.title) }

			it "has actually links towards the show, edit and delete actions" do
				expect(find_by_id("show_breve_#{@breve.id}")[:href]).to eql(breve_path(@breve))
				expect(element_not_found?("delete_breve_#{@breve.id}")).to be_true
			end

			describe "Clicking on the breve title displays the breve show page" do
				before do
					click_link("show_breve_#{@breve.id}")
				end
				it "displays the breve show page" do
					expect(current_path).to eql(breve_path(@breve))
				end
			end	
		end

		describe "Signed in users" do
			let(:user) {FactoryGirl.create(:user)}
			before do
				@breve = FactoryGirl.create(:breve)
				sign_in user
				visit breve_path(@breve)
			end 

			describe "Clicking the delete link deletes the breve and renders the breves list page" do
				it "decreases by 1 the number of breves" do
					expect{click_link("delete_breve_#{@breve.id}")}.to change(Breve, :count).by(-1)
				end
				it "displays the breves list page" do
					click_link("delete_breve_#{@breve.id}")
					expect(current_path).to eql(breves_path)
				end
				it "does not display the deleted breve" do
					click_link("delete_breve_#{@breve.id}")
					expect(Breve.exists?(@breve)).to be_false
				end
			end
		end
			
	end

end

