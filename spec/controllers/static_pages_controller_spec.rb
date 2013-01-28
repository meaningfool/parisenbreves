require 'spec_helper'

describe StaticPagesController do

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end
  end

  describe "GET 'content'" do
    it "returns http success" do
      get 'content'
      response.should be_success
    end
  end

  describe "GET 'contribute'" do
    it "returns http success" do
      get 'contribute'
      response.should be_success
    end
  end

end
