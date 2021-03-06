class CommentsController < ApplicationController

  def show
    @comment = Comment.find(params[:id])
    @title = "should be first ~100 characters in post"
    @comments = Comment.find_by_parent_id(@comment.id)
  end

  def new  #### don't think I need a new page
    #@comment = Comment.new
    #@title = "Submit a comment"
  end

  def create
    @comment = current_user.comments.build(params[:comment])
    if @comment.save
      flash[:success] = "Comment posted!"
      @comment.send_notification
      redirect_to (@comment.parent ? @comment.parent : @comment.link)
    else
      redirect_to root_path
    end
  end

  def destroy
    @comment.destroy
  end

end
