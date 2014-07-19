require 'spec_helper'

describe "UserPages" do

  subject { page }
  
  after(:all) { User.delete_all }
  
  describe "profile page" do
    

    let(:u) { FactoryGirl.create(:user) } 
    
    
    
    before { visit user_path(u) }
    
    it { should have_content(u.name) }
    it { should have_selector('title', text: full_title(u.name)) }
  end
  
  describe "signup page" do
    before { visit signup_path }
    
    it { should have_content('Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end


end
