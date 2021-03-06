class Comment < ActiveRecord::Base
  attr_accessible :content, :link_id, :parent_id, :commenter_id
  
  belongs_to :commenter, :class_name => "User"
  belongs_to :link
  belongs_to :parent, :class_name => "Comment"
  
  has_many :votes, :as => :votable
  has_many :replies, :class_name => "Comment", :foreign_key => "parent_id"
    
  def submitter
    return commenter
  end
      
  def is_root?
    !parent
  end
    
  def send_notification
    if is_root?
      UserMailer.link_comment_notification(self).deliver  
    else
      UserMailer.reply_notification(self).deliver
    end  
  end
  
end