namespace :db do
  desc "Fill database with sample data"
  
  task populate: :environment do
    #make_admin
    make_users
    make_microposts
    make_relationships               
  end
end

def make_users    
  xq =   User.create!(
    name: "Xiaoqing",
    email: "helen.zhang28@gmail.com",
    username: "xq",
    password: "foobar",
    password_confirmation: "foobar",
    )
    
  sweetbear =   User.create!(
    name: "Sweet Bear",
    email: "sweetbear826@gmail.com",
    username: "sbear",
    password: "foobar",
    password_confirmation: "foobar",
    )

  zg_qq =   User.create!(
    name: "Zhongming",
    email: "zhongming.guan@qq.com",
    username: "zg_qq",
    password: "foobar",
    password_confirmation: "foobar",
    admin: true
    )   
    
  zg =   User.create!(
    name: "Zhongming",
    email: "zhongm.guan@gmail.com",
    username: "zg_gmail",
    password: "foobar",
    password_confirmation: "foobar",
    admin: true
    )         
  
  10.times do |n|
    name  = Faker::Name.name
    email = Faker::Internet.email
    #email = "example-#{n+1}@railstutorial.org"
    username = Faker::Internet.user_name(4..12) + n.to_s
    password = "foobar"
    User.create!(name: name, 
                 email: email, 
                 username: username,
                 password: password, 
                 password_confirmation: password)
  end 
end

def make_microposts
  users = User.all.limit(6)
  10.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end  
end

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..10]
  followers      = users[3..8]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end