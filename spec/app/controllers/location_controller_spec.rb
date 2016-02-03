# encoding: utf-8

require 'spec_helper'



describe "The www subdomain" do
  it "should be the homepage" do
    visit "http://www.hasbeen.test"
    page.status_code.should == 200
    current_url.should == "http://www.hasbeen.test/"
    page.should have_content "Hej."
    page.should have_content "Have a look at the places Bascht, Bjørn Lynne, Encoding Connoisseur, Franz Josef, Maximilian and Phrawzty have been to. "
    page.title.should eq "hasbeen.in · Places we have been."
  end

  it "should have links to the correct travellers" do
    visit_profile "www"
    click_link "Bjørn Lynne"
    current_url.should == "http://bjoern.hasbeen.test/"
    page.status_code.should == 200
    page.should have_content "Bjørn Lynne"
  end
end

describe "Profiles" do
  it "should have some properties and link to themselves" do
    visit_profile "bascht"
    page.status_code.should == 200
    page.should have_content "Bascht"
    click_link("Bascht")
    page.status_code.should == 200
    page.should have_content "Bascht has been in Leipzig, Hamburg, Oelsnitz, Bangkok, Shanghai and Amerika."
    page.title.should eq "hasbeen.in · Places bascht has been."
    current_url.should == "http://bascht.hasbeen.test/"
  end

  it "should have clickable location links" do
    visit_profile "bascht"
    click_link("Leipzig")
    page.status_code.should == 200
    page.should have_content "Bascht has been in Leipzig."
    page.html.should include "<script>goto('Leipzig');</script>"
    current_url.should == "http://bascht.hasbeen.test/Leipzig"
  end

  it "should allow hinting to the correct places" do
    visit_profile "bascht"
    click_link("Amerika")
    page.status_code.should == 200
    page.should have_content "Bascht has been in Amerika."
    page.html.should include "<script>goto('Amerika%2C+Penig%2C+Deutschland');</script>"
    current_url.should == "http://bascht.hasbeen.test/Amerika"
  end

  it "should take care of unicode" do
    visit_profile "bjoern"
    page.should have_content "Bjørn Lynne has been in no locations yet."
  end

  it "should generate readable sentences" do
    visit_profile "franz"
    page.should have_content "Franz Josef has been in Leipzig and Shanghai."
  end

  it "should handle current hometown" do
    visit_profile "encoder"
    page.status_code.should == 200
    page.should have_content "Encoding Connoisseur's current hometown is Munich."
    click_link("Munich")
    page.status_code.should == 200
    page.should have_content "Encoding Connoisseur has been in Munich. This is Encoding Connoisseur's current hometown."
    page.html.should include "<script>goto('Munich');</script>"
    current_url.should == "http://encoder.hasbeen.test/Munich"
  end

  it "should be pedantic when it comes to phrawzty's profile" do
    visit_profile "phrawzty"
    page.should have_content "Phrawzty has been to Grammar School."
    click_link("Grammar School")
    page.should have_content "Phrawzty has been to Grammar School."
  end
end

describe "Locations" do
  it "should handle unknown locations" do
    visit_profile "bascht", "Hierwarnochkeinschwein"
    page.status_code.should == 404
    page.should have_content "Bascht hasn't been in Hierwarnochkeinschwein."
    page.html.should include "<script>goto('Hierwarnochkeinschwein');</script>"
  end

  it "should be case insensitive" do 
    visit_profile "bascht", "leipzig"
    page.status_code.should == 200
    page.should have_content "Bascht has been in Leipzig."
    page.html.should include "<script>goto('Leipzig');</script>"
    current_url.should == "http://bascht.hasbeen.test/leipzig"
  end
end
