require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "A traveller" do

  let(:traveller) { traveller = Travellers.find("Bascht") }

  it "should initialize with a name and some Properties" do
    traveller.name.should == "Bascht"
    traveller.profile.should == { 
      "web"       => "http://bascht.com",
      "twitter"   => "bascht",
      "gravatar"  => "8656dc5476c819d4dcbd932a5744122a"
    }
  end

  it "should have been to some location" do
    traveller.locations.count.should == 5
    traveller.locations.should == [ 
      "Leipzig", 
      "Hamburg", 
      "Oelsnitz", 
      "Bangkok", 
      "Shanghai" 
    ]
  end

  it "should know where it has been" do
    traveller.hasbeen_in?("Leipzig").should == true
    traveller.hasbeen_in?("Buxtehude").should == false
  end

  it "should not be case sensitive" do
    traveller.hasbeen_in?("leipzig").should == true
    traveller.hasbeen_in?("BUXTEHUDE").should == false
  end

  it "should give me a list of travellers" do
    travellers = Travellers.find_all
    travellers.should == [
      Travellers.find("bascht"),
      Travellers.find("bjoern"),
      Travellers.find("franz"),
      Travellers.find("max")
    ]
  end
end
