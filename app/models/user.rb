# == Schema Information
# Schema version: 20110216230007
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'digest'
class User < ActiveRecord::Base
  attr_accessor :password, :new_password
  attr_accessible :name, :email, :password, :password_confirmation

  has_many :microposts, :dependent => :destroy
  has_many :relationships,  :foreign_key => "follower_id",
                            :dependent => :destroy
  has_many :following, :through => :relationships, :source => :followed
  has_many :reverse_relationships,  :foreign_key => "followed_id",
                                    :class_name => "Relationship",
                                    :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower
  has_many :links
  has_many :votes, :foreign_key => "voter_id"
  has_many :comments, :foreign_key => "commenter_id"

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name,    :presence     => true,
                      :length       => { :maximum => 50 }
  validates :email,   :presence     => true,
                      :format       => { :with => email_regex },
                      :uniqueness   => { :case_sensitive => false }
  validates :password,:presence     => true,
                      :confirmation => true,
                      :length       => { :within => 6..40 }
  
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    return nil  if user.nil?
    return user if user.salt == cookie_salt
  end
  
  def following?(followed)
    relationships.find_by_followed_id(followed)
  end
  
  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end
  
  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end
  
  def feed
    Micropost.from_users_followed_by(self)
  end
  
  def karma
    vote_total(links) + vote_total(comments) + 1
  end
  
  def vote_for!(votable) 
    unless ineligible_to_vote_for? votable
      votes.create!(:votable_id => votable.id,
                    :votable_type => votable.class.name,
                    :direction => nil)
      votable.update_score  if votable.class.name == "Link"
    end
  end
  
  def ineligible_to_vote_for?(votable)
    already_voted_for?(votable) || is_submitter_of?(votable)
  end
  
  def is_submitter_of?(votable)
    votable.submitter.id == id
  end
  
  def already_voted_for?(votable)
    votable.votes.find_by_voter_id(id)
  end
  
  private
  
    def vote_total(votables)
      total = 0
      votables.each {|v| total += v.votes.count}
      return total
    end
      
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
    
end