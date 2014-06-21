require 'spec_helper'

describe "StaticPages" do
  describe "Home page" do
    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      page.should have_content('Sample App')
    end
    
    # A title test
    it "should have the right title" do
      visit '/static_pages/home'
      page.should have_selector('title', :text => "Home" )
    end
  end
  
  describe "Help page" do
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      page.should have_content('Help')
    end
    
    #A title test
    it "should have the right title" do
      visit '/static_pages/help'
      page.should have_selector('title', :text => "Help")
    end
  end
  
  describe "About page" do
    it "should have the contnet 'About Us'" do
      visit '/static_pages/about'
      page.should have_content('About Us')
    end
    
    # A title test
    it "should have the right title" do
      visit '/static_pages/about'
      page.should have_selector('title', :text => "About Us")
    end
  end  
end
