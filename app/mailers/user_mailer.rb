class UserMailer < ActionMailer::Base
  default from: 'noreply@thawing-forest-2183.herokuapp.com'
  
  def follower_notification(follower, followed)
    @follower = follower
    @followed = followed
    mail(
      to: "#{followed.name} <#{followed.email}>", 
      subject: 'NOREPLY: You have a new follower')
  end
  
end
