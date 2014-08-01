class User < ActiveRecord::Base
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower
  
  before_save { email.downcase! } # OR: before_save { self.email = email.downcase }
  before_create :create_remember_token
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  
  VALID_USERNAME_REGEX = /\A(\w|-|\.)+\z/i
  validates :username, presence: true, length: { maximum: 16 }, format: { with: VALID_USERNAME_REGEX }, uniqueness: true
  
  has_secure_password
  validates :password, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  
  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  def feed
    # This is preliminary. 
    # Micropost.where("user_id = ?", id)
    
    Micropost.from_users_followed_by(self)
  end
  
  def following?(other_user)
    self.relationships.find_by(followed_id: other_user.id)
  end
  
  def follow!(other_user)
    # We can omit the user itself, and just write: 
    # relationships.create!(followed_id: other_user.id).
    # But, it's more readable if we add the self at the beginning
    self.relationships.create!(followed_id: other_user.id)
  end
  
  def unfollow!(other_user)
    self.relationships.find_by(followed_id: other_user.id).destroy
  end
  
  # ZG Note: 2014-08-01 00:22 am
  #
  # We will send "follower notification" to the user who is followed by  
  # current_user.
  # The receiver of message/method - "send_follower_notification"
  # will be the user who is followed by current_user.
  # We will call method - "send_follower_notification" inside relationships_controller.rb like:
  # @user.send_follower_notification(current_user)
  # This is why we use "follower" as a param for method - "send_follower_notification".
  # 
  # The same thing, we define method - "follower_notification(followed, follower)",
  # we are trying to say:
  # send follower notification to the user who is followed, along with
  # the follower (i.e., current_user)
  def send_follower_notification(follower)
    UserMailer.follower_notification(self, follower).deliver
  end
  
  private
  
    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
  
end
