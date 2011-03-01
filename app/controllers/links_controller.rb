class LinksController < ApplicationController
  
  def index
    @title = "Links"
    @links = Link.all
  end
  
  def show
    @link = Link.find(params[:id])
    @title = @link.headline
    @comment = Comment.new
    @comments = @link.comments
  end
  
  def new
    @link = Link.new
    @title = "Submit a link"
  end
  
  def create
    @link = current_user.links.build(params[:link])
    if @link.save
      redirect_to links_path
    else
      redirect_to root_path
    end
  end
  
  def destroy
    @link.destroy
  end

end
