class Comment < ActiveRecord::Base
  attr_accessible :content, :link_id, :parent_comment_id, :commenter_id
  
  belongs_to :commenter, :class_name => "User"
  belongs_to :link
  
  has_many :votes, :as => :votable
    
  def submitter_id
    return commenter_id
  end
  
end