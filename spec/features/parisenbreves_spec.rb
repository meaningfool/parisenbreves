#!/usr/bin/env ruby -w
# encoding: UTF-8

require 'spec_helper'

describe "Breve pages" do
	subject { page }

	describe "Breve show page" do
		before do 
			@test_breve = FactoryGirl.create(:breve)
			visit breve_path(@test_breve)
		end

		it { should have_selector('.title', :text => @test_breve.title) }
		it { should have_selector('.location', :text => @test_breve.location)}
		it { should have_selector('.description'), :text => @test_breve.description}

		it { should have_selector('.source', :text => @test_breve.source_name)}
		it { should have_link(@test_breve.source_name, :href => @test_breve.source_URL)}
		it { should have_selector('.latitude', :text => @test_breve.latitude.to_s)}
		it { should have_selector('.longitude', :text => @test_breve.longitude.to_s)}

	end

	describe "Breve new page" do

		before do
			@new_breve = Breve.new
			visit new_breve_path(@new_breve)
		end

		describe "The structure of the page" do 
			it {should have_field('breve_title')}
			it {should have_field('breve_location')}
			it {should have_field('breve_description')}
			it {should have_field('breve_source_name')}
			it {should have_field('breve_source_URL')}
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

			describe "The breve information have been saved" do	
				before {click_button "submit"}
				it { should have_selector('.title', :text => @new_breve.title) }
				it { should have_selector('.location', :text => @new_breve.location)}
				it { should have_selector('.description'), :text => @new_breve.description}

				it { should have_selector('.source', :text => @new_breve.source_name)}
				it { should have_link(@new_breve.source_name, :href => @new_breve.source_URL)}
				it { should have_selector('.latitude', :text => @new_breve.latitude.to_s)}
				it { should have_selector('.longitude', :text => @new_breve.longitude.to_s)}
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

			it "redirects to the new page" do
				expect(current_path).to eql(new_breve_path(@new_breve))
			end

			describe "The form should display the field values entered before submitting" do
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
		before do
			@edit_breve = FactoryGirl.create(:breve)
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
				it { should have_selector('.title', :text => @new_breve.title) }
				it { should have_selector('.location', :text => @new_breve.location)}
				it { should have_selector('.description'), :text => @new_breve.description}

				it { should have_selector('.source', :text => @new_breve.source_name)}
				it { should have_link(@new_breve.source_name, :href => @new_breve.source_URL)}
				it { should have_selector('.latitude', :text => @new_breve.latitude.to_s)}
				it { should have_selector('.longitude', :text => @new_breve.longitude.to_s)}
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

			it "redirects to the new page" do
				expect(current_path).to eql(edit_breve_path(@edit_breve))
			end

			describe "The form should display the field values entered before submitting" do
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

	describe "Breve list page" do
		before do
			@breve = FactoryGirl.create(:breve)
			visit breves_path
			#save_and_open_page
		end

		describe "The page displays the breve and the edit and delete links" do
			it { should have_selector('.title', :text => @breve.title) }

			it "has links with the appropriate ids for show, edit and delete" do
				expect { find("#show_breve_#{@breve.id}").not_to be_nil}
				expect { find("#edit_breve_#{@breve.id}").not_to be_nil}
				expect { find("#delete_breve_#{@breve.id}").not_to be_nil}
			end
			it "has actually links towards the show, edit and delete actions" do
				expect { find("#show_breve_#{@breve.id}")[:href].to eql(breve_url(@breve)) }
				expect { find("#edit_breve_#{@breve.id}")[:href].to eql(edit_breve_url(@breve)) }
				expect { find("#delete_breve_#{@breve.id}")[:method].to eql("delete") }
			end
		end

		describe "Clicking on the breve title displays the breve show page" do
			before do
				click_link("show_breve_#{@breve.id}")
			end
			it "displays the breve show page" do
				expect(current_path).to eql(breve_path(@breve))
			end
		end

		describe "Clicking on the breve edit link displays the breve show page" do
			before do
				click_link("edit_breve_#{@breve.id}")
			end
			it "displays the breve edit page" do
				expect(current_path).to eql(edit_breve_path(@breve))
			end
		end

		describe "Clicking the delete link deletes the breve and renders the breves list page" do
			it "decreases by 1 the number of breves" do
				expect{click_link("delete_breve_#{@breve.id}")}.to change(Breve, :count).by(-1)
			end
			it "displays the breves list page" do
				expect(current_path).to eql(breves_path)
			end
			it "does not display the deleted breve" do
				expect { find("#show_breve_#{@breve.id}").to be_nil}
			end
		end
	end

end

=begin
feature "Breve management" do

	scenario "display some breves" do
		@breve = Breve.create :title => 'titre de ma premiere breve', :description => 'texte de ma premiere breve'
		visit breves_path
		page.should have_content 'premiere breve'
	end

	scenario "create a breve" do
		visit	breves_path
		fill_in 'Title', :with => 'titre de ma deuxieme breve'
		click_button 'Create Breve'

		current_path.should == breves_path
		page.should have_content'deuxieme breve'

		#save_and_open_page
	end

	scenario "edit a breve" do
		@breve = Breve.create :title => 'titre de ma premiere breve', :description => 'texte de ma premiere breve'
		visit breves_path
		click_link 'Edit'

		current_path.should == edit_breve_path(@breve)

		find_field('Title').value.should == 'titre de ma premiere breve'

		fill_in 'Title', :with => 'titre mis à jour'
		click_button 'Update Breve'

		current_path.should == breves_path

		page.should have_content 'titre mis à jour'
	end

	scenario "null the title" do
		@breve = Breve.create :title => 'titre de ma premiere breve', :description => 'texte de ma premiere breve'
		visit breves_path
		click_link 'Edit'

		fill_in 'Title', :with => ''
		click_button 'Update Breve'

		current_path.should == edit_breve_path(@breve)

		page.should have_content 'There was an error updating the breve'
	end
end
=end
