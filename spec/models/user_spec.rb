# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe User do
  #pending "add some examples to (or delete) #{__FILE__}"
  before { @user = User.new(name: "Test User", email: "tu@gmail.com") }
  subject { @user }
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  
  it { should be_valid }
  
  describe "when name is not present" do
    before { @user.name = "" }
    it { should_not be_valid }
  end
  
  describe "when email is not present" do
    before { @user.email = "" }
        
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @user.name = "a"*51 }
    it { should_not be_valid }
  end
  
end
