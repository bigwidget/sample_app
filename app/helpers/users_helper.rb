module UsersHelper

  def gravatar_for(user, options = { :size => 50})
    gravatar_image_tag(user.email.downcase, :alt => user.name,
                                            :class => 'gravatar',
                                            :gravatar => options)
  end
  
  def replies_link(comment)
    if !comment.replies.empty?
      link_to pluralize(comment.replies.count, "reply"), comment
    else
      return nil
    end
  end
  
end
