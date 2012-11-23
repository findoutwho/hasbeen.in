require 'spec_helper'
#require 'pry'

describe "Profiles" do
  before(:each) do
    visit "http://bascht.hasbeen.in"
  end

  it "should have some properties" do
    page.status_code.should == 200
    page.should have_content "Bascht"
  end

  it "should link to themselves" do
    click_link("Bascht")
    page.status_code.should == 200
    page.should have_content "Bascht has been in Leipzig, Hamburg, Oelsnitz, Bangkok and Shanghai."
    current_url.should == "http://bascht.hasbeen.in/"
  end

  it "should have clickable location links" do
    click_link("Leipzig")
    page.status_code.should == 200
    page.should have_content "Bascht has been in Leipzig."
    current_url.should == "http://bascht.hasbeen.in/Leipzig"
  end
end

describe "Locations" do
  it "should handle unknown locations" do
    visit "http://bascht.hasbeen.in/Hierwarnochkeinschwein/"
    page.status_code.should == 404
    page.should have_content "Bascht hasn't been in Hierwarnochkeinschwein."
  end
end
