require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_microposts
    make_relationships
    make_links
    make_votes
    make_comments
  end
end

def make_users
  admin = User.create!(:name => "Example User",
               :email => "example@railstutorial.org",
               :password => "foobar",
               :password_confirmation => "foobar")
  admin.toggle!(:admin)    

  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    User.create!(:name => name,
                 :email => email,
                 :password => password,
                 :password_confirmation => password)
  end
end

def make_microposts
  User.all(:limit => 6).each do |user|
    50.times do
      user.microposts.create!(:content => Faker::Lorem.sentence(5))
    end
  end
end
    
def make_relationships
  users = User.all
  user  = users.first
  following = users[1..50]
  followers = users[3..40]
  following.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end

def make_links
  users = User.all
  35.times do |n|
    user = users[n]
    url = Faker::Internet.domain_name
    headline = Faker::Lorem::sentence(2 + rand(4))
    user.links.create!(:url => url, :headline => headline)
  end
end

def make_votes
  num_users = User.all.count
  Link.all(:limit => 10).each do |link|
    rand(10).times do |vote|
      User.find(rand(num_users)).vote_for!(link)
    end
  end
end

def make_comments
end