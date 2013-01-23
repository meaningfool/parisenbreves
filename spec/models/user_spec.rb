require 'spec_helper'

describe User do
	before { @user = FactoryGirl.build(:user)}

	subject {@user}

	it { should respond_to(:name)}
	it { should respond_to(:email)}
	it { should respond_to(:password_digest)}
	it { should respond_to(:password)}
	it { should respond_to(:password_confirmation)}
	it { should respond_to(:authenticate)}
	it { should respond_to(:remember_token)}
	it { should respond_to(:admin)}

	it { should be_valid}
	it { should_not be_admin }

	describe "with admin attribute set to true" do
		before do 
			@user.save!
			@user.toggle!(:admin)
		end

		it {should be_admin}
	end

	describe "Name validation" do
		it "is invalid without a name" do 
			expect(FactoryGirl.build(:user, name: nil)).to_not be_valid 
		end
		it "is invalid with a blank name" do
			expect(FactoryGirl.build(:user, name: " ")).to_not be_valid
		end
		it "is invalid with >50 characters" do 
			expect(FactoryGirl.build(:user, name: "a"*51)).to_not be_valid
		end

		describe "when name format is invalid" do
		    it "should be invalid" do
		      	names = %w[R.f fibzdon?zdeez]
		      	names.each do |invalid_name|
		        		@user.name = invalid_name
		        		@user.should_not be_valid
	      		end      
	    	end
	  	end

	  	describe "when name format is valid" do
		    it "should be valid" do
				names = %w[iridan_zefn _zefezf6345]
				names.each do |valid_name|
					@user.name = valid_name
					@user.should be_valid
				end      
		    end
		end

		describe "when name is already taken" do
			before do
				@user.save
				@user_with_same_name = @user.dup
				@user_with_same_name.name = @user.name.upcase
			end
			it "does not save" do
				expect(@user_with_same_name.save).to be_false
			end
		end
	end

	describe "Email validation" do
		it "is invalid without an email" do
			expect(FactoryGirl.build(:user, email: nil)).to_not be_valid
		end
		it "is invalid with a blank email" do 
			expect(FactoryGirl.build(:user, email: " ")).to_not be_valid
		end
  	
	  	describe "when email format is invalid" do
		    it "should be invalid" do
		      	addresses = %w[user@foo,com user_at_foo.org example.user@foo.
		                     foo@bar_baz.com foo@bar+baz.com]
		      	addresses.each do |invalid_address|
		        		@user.email = invalid_address
		        		@user.should_not be_valid
	      		end      
	    	end
	  	end

	  	describe "when email format is valid" do
		    it "should be valid" do
				addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
				addresses.each do |valid_address|
					@user.email = valid_address
					@user.should be_valid
				end      
		    end
		end

		describe "when email address is already taken" do
			before do
				@user.save
				@user_with_same_email = @user.dup
				@user_with_same_email.email = @user.email.upcase
			end
			it "does not save" do
				expect(@user_with_same_email.save).to be_false
			end
		end
  	end

  	describe "Password validation" do
  		it "cannot have a nil password" do
  			expect(FactoryGirl.build(:user, password: nil)).to_not be_valid
  		end
  		it "cannot have a blank password" do
	  		expect(FactoryGirl.build(:user, password: " ", password_confirmation: " ")).to_not be_valid
	  	end
	  	it "cannot have a password shorter than 6 characters" do
	  		expect(FactoryGirl.build(:user, password: "a"*5, password_confirmation: "a"*5)).to_not be_valid
	  	end
	  	it " cannot have a mismatch between Password and Password confirmation" do
	  		expect(FactoryGirl.build(:user, password_confirmation: "mismatch")).to_not be_valid
	  	end
  	end

  	describe "Authentication validation" do
  		before { @user.save }
  		let(:found_user) {User.find_by_email(@user.email)}

  		it "authenticates with the right password" do
  			expect(found_user.authenticate(@user.password)).to eql(@user)
  		end

  		it "does not authenticate with any other password" do
  			expect(found_user.authenticate("invalid")).to be_false
  		end
  	end

  	describe "remember token" do
		before { @user.save }
		its(:remember_token) { should_not be_blank }
  	end

end
