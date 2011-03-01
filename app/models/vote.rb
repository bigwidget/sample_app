class Vote < ActiveRecord::Base
  
  attr_accessible :link_id
  
  belongs_to :link
  belongs_to :voter, :class_name => "User"
  
  #validates :direction, :inclusion => { :in => -1..1 }

end
