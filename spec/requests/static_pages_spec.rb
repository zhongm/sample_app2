require 'spec_helper'

describe "StaticPages" do
  
  let(:base_title) {"Sample app"}
  
  describe "Home page" do
    it "should have the content 'Sample App'" do
      visit '/static_pages/home'
      page.should have_content('Sample App')
    end
    
    # A title test
    it "should have the base title" do
      visit '/static_pages/home'
      page.should have_selector('title', :text => "#{base_title}")
    end
    
    it "should not have a custom page title" do
      visit '/static_pages/home'
      page.should_not have_selector('title', :text => "Home | " )
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
      page.should have_selector('title', :text => "Help | #{base_title}")
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
      page.should have_selector('title', :text => "About Us | #{base_title}")
    end
  end  
  
  describe "Contact page" do
    it "should have the content 'Contact'" do
      visit '/static_pages/contact'
      page.should have_content('Contact')
    end
    
    # A title test
    it "should have the right title" do
      visit '/static_pages/contact'
      page.should have_selector('title', :text => "Contact | #{base_title}")
    end
  end
end
