module SharedHelper
  
  def link_text(item)
    if(item.class.name == "Link")
      item.comments.empty? ? "discuss" : pluralize(item.comments.count, "comment")
    else
      "link"
    end
  end

end