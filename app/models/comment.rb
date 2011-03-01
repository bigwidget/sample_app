class Comment < ActiveRecord::Base
  attr_accessible :content, :link_id, :parent_comment_id, :commenter_id
  
  belongs_to :commenter, :class_name => "User"
  belongs_to :link
    
end