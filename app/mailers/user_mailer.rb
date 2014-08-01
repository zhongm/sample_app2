class UserMailer < ActionMailer::Base
  default from: 'noreply@thawing-forest-2183.herokuapp.com'
  
  def follower_notification(followed, follower)
    @followed = followed
    @follower = follower
    mail(
      to: "#{followed.name} <#{followed.email}>", 
      subject: 'NOREPLY: You have a new follower')
  end
  
end
