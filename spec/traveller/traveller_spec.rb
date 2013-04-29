# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "A traveller" do

  let(:traveller) { traveller = Travellers.find("Bascht") }
  let(:encoding_junkie) { traveller = Travellers.find("encoder") }
  let(:amerika)   { traveller.find_location("Amerika") }

  it "should initialize with a name and some Properties" do
    traveller.name.should == "Bascht"
    traveller.username.should == "bascht"
    traveller.profile.should == {
      "web"       => "http://bascht.com",
      "twitter"   => "bascht",
      "gravatar"  => "8656dc5476c819d4dcbd932a5744122a"
    }
  end

  it "should have been to some location" do
    traveller.locations.count.should == 6
    traveller.locations.should == [
      "Leipzig",
      "Hamburg",
      "Oelsnitz",
      "Bangkok",
      "Shanghai",
      "Amerika"
    ]
  end

  # Yep, Amerika is a part of a small town in saxony.
  it "should allow to give hints" do
    traveller.hasbeen_in?("Amerika").should == true
    amerika.should == "Amerika"
    amerika.hint.should == "Amerika, Penig, Deutschland"
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
      Travellers.find("encoder"),
      Travellers.find("franz"),
      Travellers.find("max")
    ]
  end

  it "should survive different encoding styles" do
    encoding_junkie.hasbeen_in?("Wrocław").should == true
    encoding_junkie.hasbeen_in?("St. John's").should == true
    encoding_junkie.hasbeen_in?("重庆").should == true
    aliased_chinese_city = encoding_junkie.find_location("重庆")
    aliased_chinese_city.should == "重庆"
    aliased_chinese_city.hint.should == "Chóngqìng"
  end
end
