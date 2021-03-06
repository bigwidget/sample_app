class LinksController < ApplicationController
  
  def index
    @title = "Links"
    @links = Link.paginate(:page => params[:page], :per_page => 10)
  end
  
  def show
    @link = Link.find(params[:id])
    @title = @link.headline
    @comment = Comment.new
    @root_comments = root_level(@link.comments)
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
  
  private
  
  def root_level(comments)
    comments.select { |comment| comment.is_root? }
  end

end
