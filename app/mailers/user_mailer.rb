class UserMailer < ActionMailer::Base
  default :from => "Libertarian Hive <info@hivechatter.com>"

  def reply_notification(comment)
    @thread = comment.link.headline
    @parent_comment = comment.parent.content
    @parent_commenter = comment.parent.commenter.name
    @commenter = comment.commenter.name
    @comment = comment
    mail( :to => "#{@parent_commenter} <tim@mytype.com>",
          :subject => "#{@commenter} replied to your comment")
  end
  
  def link_comment_notification(comment)
    @headline = comment.link.headline
    @submitter = comment.link.submitter.name
    @comment = comment
    @commenter = comment.commenter.name
    mail( :to => "#{@submitter} <tim@mytype.com>",
          :subject => "#{@commenter} commented on your link")
  end    
  
end
