# encoding: utf-8

require 'spec_helper'

describe "The www subdomain" do
  it "should not be mapped to travellers" do
    visit_profile "www"
    page.status_code.should == 200
    current_url.should == "http://hasbeen.in/"
    page.should have_content "Hej."
    page.should have_content "Have a look at the places Bascht, Bjørn Lynne, Franz Josef and Maximilian have been to. "
  end
end

describe "Profiles" do

  it "should have some properties and link to themselves" do
    visit_profile "bascht"
    page.status_code.should == 200
    page.should have_content "Bascht"
    click_link("Bascht")
    page.status_code.should == 200
    page.should have_content "Bascht has been in Leipzig, Hamburg, Oelsnitz, Bangkok and Shanghai."
    current_url.should == "http://bascht.hasbeen.in/"
  end

  it "should have clickable location links" do
    visit_profile "bascht"
    click_link("Leipzig")
    page.status_code.should == 200
    page.should have_content "Bascht has been in Leipzig."
    current_url.should == "http://bascht.hasbeen.in/Leipzig"
  end

  it "should take care of unicode" do
    visit_profile "bjoern"
    page.should have_content "Bjørn Lynne has been in no locations yet."
  end

  it "should generate readable sentences" do
    visit_profile "franz"
    page.should have_content "Franz Josef has been in Leipzig and Shanghai."
  end
end

describe "Locations" do
  it "should handle unknown locations" do
    visit_profile "bascht", "Hierwarnochkeinschwein"
    page.status_code.should == 404
    page.should have_content "Bascht hasn't been in Hierwarnochkeinschwein."
  end
end

