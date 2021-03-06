class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def index
    #@users = User.all
    @users = User.order('id ASC').paginate(page: params[:page], per_page: 10)
  end  
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 4)
  end
  
  def create
    #@user = User.new(params[:user]) # ZG Note: not the final implementation
    
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new' 
    end
  end
  

  def edit
    #@user = User.find(params[:id])
  end
  
  def update
    #@user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      #sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end
  
  def following
    @title = "Following"
	  @user = User.find(params[:id])
	  @users = @user.followed_users.paginate(page: params[:page])
	  render 'show_follow'
  end
  
  def followers
    @title = "Followers"
	  @user = User.find(params[:id])
	  @users = @user.followers.paginate(page: params[:page])
	  render 'show_follow'
  end
  
  private 
  
    def user_params
      params.require(:user).permit(:name, :email, :username, :password, :password_confirmation)
    end
  
    # Before filters
        
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
  
end
