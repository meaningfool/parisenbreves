require 'spec_helper'

describe Breve do
	before { @user = FactoryGirl.build(:breve)}

	subject {@user}

	it { should be_valid }
	it { should respond_to(:title)}
	it { should respond_to(:location)}
	it { should respond_to(:description)}
	it { should respond_to(:source_name)}
	it { should respond_to(:source_URL)}
	it { should respond_to(:latitude)}
	it { should respond_to(:longitude)}
	it { should respond_to(:photo)}


	describe "Title validation" do
		it "is invalid without a title" do
			expect(FactoryGirl.build(:breve, title: nil)).to_not be_valid
		end
		it "is invalid with a blank title" do
			expect(FactoryGirl.build(:breve, title: " ")).to_not be_valid
		end
		it "is invalid with a title longer than 100 characters" do
			expect(FactoryGirl.build(:breve, title: "a"*101)).to_not be_valid
		end
	end

	it "is invalid with a location longer than 100 characters" do
		expect(FactoryGirl.build(:breve, location: "a"*101)).to_not be_valid
	end
	it "is invalid with a description longer than 2 000 characters" do
		expect(FactoryGirl.build(:breve, description: "a"*2001)).to_not be_valid
	end
	it "is invalid with a source name longer than 100 characters" do
		expect(FactoryGirl.build(:breve, source_name: "a"*101)).to_not be_valid
	end


	describe "Latitude validity" do
		it "is invalid without a latitude" do 
			expect(FactoryGirl.build(:breve, latitude: nil)).to_not be_valid
		end
		it "is invalid when latitude is not a float" do
			expect(FactoryGirl.build(:breve, latitude: 'aa')).to_not be_valid
		end
		it "is invalid when latitude is blank" do
			expect(FactoryGirl.build(:breve, latitude: " ")).to_not be_valid
		end
		it "is invalid when latitude inferior to -0.7854 radians" do
			expect(FactoryGirl.build(:breve, latitude: -91)).to_not be_valid
		end
		it "is invalid when latitude superior to 0.7854 radians" do
			expect(FactoryGirl.build(:breve, latitude: 91)).to_not be_valid
		end
	end

	describe "Longitude validity" do
		it "is invalid without a longitude" do 
			expect(FactoryGirl.build(:breve, longitude: nil)).to_not be_valid
		end
		it "is invalid when longitude is not a float" do
			expect(FactoryGirl.build(:breve, longitude: 'aa')).to_not be_valid
		end
		it "is invalid when longitude is blank" do
			expect(FactoryGirl.build(:breve, longitude: " ")).to_not be_valid
		end
		it "is invalid when longitude inferior to -1.5708 radians" do
			expect(FactoryGirl.build(:breve, longitude: -181)).to_not be_valid
		end
		it "is invalid when longitude superior to 1.5708 radians" do
			expect(FactoryGirl.build(:breve, longitude: 181)).to_not be_valid
		end
	end

	describe "Find near" do
		let!(:breve_NY) do
			FactoryGirl.create(:breve, title: "breve NY", latitude: 40.71, longitude: -74, updated_at: 1.day.ago)
		end
		let!(:breve_Vanves) do
			FactoryGirl.create(:breve, title: "breve Vanves", latitude: 48.82, longitude: 2.3, updated_at: 2.days.ago)
		end
		let!(:breve_Bordeaux) do
			FactoryGirl.create(:breve, title: "breve Bordeaux", latitude: 44.83, longitude: -0.57, updated_at: 3.days.ago)
		end
		it do
			@reference_point = [48.85, 2.35]
			ordered = Breve.find_near(@reference_point,10000)
			expect(ordered[0]).to eql(breve_Vanves)
			expect(ordered[1]).to eql(breve_Bordeaux)
			expect(ordered[2]).to eql(breve_NY)
		end
	end

end
