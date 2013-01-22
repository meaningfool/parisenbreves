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
			expect(FactoryGirl.build(:breve, latitude: -0.79)).to_not be_valid
		end
		it "is invalid when latitude superior to 0.7854 radians" do
			expect(FactoryGirl.build(:breve, latitude: 0.79)).to_not be_valid
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
			expect(FactoryGirl.build(:breve, longitude: -1.5708)).to_not be_valid
		end
		it "is invalid when longitude superior to 1.5708 radians" do
			expect(FactoryGirl.build(:breve, longitude: 1.5708)).to_not be_valid
		end
	end
end
