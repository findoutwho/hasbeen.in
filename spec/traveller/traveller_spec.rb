require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "A traveller" do

  let(:traveller) { traveller = Traveller.find("Bascht") }

  it "should initialize with a name and some Properties" do
  end

  it "should initialize with a name and some Properties" do
    traveller.name.should == "Bascht"
    traveller.profile.should == { 
      "web"     => "http://bascht.com", 
      "twitter" => "bascht", 
      "email"   => "github.com@bascht.com" 
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
end
