namespace :db do
  desc "Fill database with sample data"
  
  task populate: :environment do
    make_users
    make_microposts
               
  end
end


def make_users
  admin = User.create!(name: "Example Uesr",
               email: "example@railstutorial.org",
               password: "foobar",
               password_confirmation: "foobar",
               admin: true)
  
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "foobar"
    User.create!(name: name, 
                 email: email, 
                 password: password, 
                 password_confirmation: password)
  end 
end

def make_microposts
  users = User.all.limit(6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end  
end