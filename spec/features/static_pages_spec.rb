require 'spec_helper'

describe "Static Pages" do
	describe "Content path" do
		before { visit content_path }
		it { expect(current_path).to eql('/contenus') }
	end
	describe "Contribute path" do
		before { visit contribute_path }
		it { expect(current_path).to eql('/contribuer')}
	end
end

describe "Ordered breves list" do

	subject { page }
	
	let!(:breve_NY) do
		FactoryGirl.create(:breve, title: "breve NY", latitude: 40.71, longitude: -74, updated_at: 1.day.ago)
	end
	let!(:breve_Vanves) do
		FactoryGirl.create(:breve, title: "breve Vanves", latitude: 48.82, longitude: 2.3, updated_at: 2.days.ago)
	end
	let!(:breve_Bordeaux) do
		FactoryGirl.create(:breve, title: "breve Bordeaux", latitude: 44.83, longitude: -0.57, updated_at: 3.days.ago)
	end

	before { visit root_path }

	describe "Time ordered breve list" do
		it "should render the breves from the closest to furthest from Paris center" do
			#save_and_open_page
			page.all(:xpath, ".//ul[@id = 'time_ordered']/li[1]")[0].should have_content("NY")
			page.all(:xpath, ".//ul[@id = 'time_ordered']/li[2]")[0].should have_content("Vanves")
			page.all(:xpath, ".//ul[@id = 'time_ordered']/li[3]")[0].should have_content("Bordeaux")
			#binding.pry
		end
	end
	describe "Distance ordered breve list" do
		it "should render the breves from the closest to furthest from Paris center" do
			#save_and_open_page
			page.all(:xpath, ".//ul[@id = 'distance_ordered']/li[1]")[0].should have_content("Vanves")
			page.all(:xpath, ".//ul[@id = 'distance_ordered']/li[2]")[0].should have_content("Bordeaux")
			page.all(:xpath, ".//ul[@id = 'distance_ordered']/li[3]")[0].should have_content("NY")
			#binding.pry
		end
	end
end