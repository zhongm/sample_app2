class RelationshipsController < ApplicationController
  before_action :signed_in_user
  
  def create
    
    # ZG note: because we are going to create a new relationship (i.e., we don't know the primary key id yet)
    # So, we have to code like below: 
    # User.find...
    
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    
    follower = current_user
    followed = @user
    UserMailer.follower_notification(follower, followed).deliver
    
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
  
  def destroy
    # ZG note (2014-07-26 22:46 pm): check the source file created by "_unfollow.html.erb", we can see: 
    # <form accept-charset="UTF-8" action="/relationships/1" class="edit_relationship" id="edit_relationship_1" method="post">
    # <input name="_method" type="hidden" value="delete" />
    # Please note: relationships table also has a primary key - id (just like other tables)
 
    # It's a good way to check the source file when you don't how to code a method inside a controller like 
    # this scenario here.
     
    # Relationship, belongs_to :followed, class_name: "User"
    # We can open up a rails console to check the code below,
    # so we can easily understand it.
     
    @user = Relationship.find(params[:id]).followed 
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
  
end