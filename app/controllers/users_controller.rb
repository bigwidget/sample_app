class UsersController < ApplicationController
#  before_filter :authenticate, :except => [:show, :new, :create]
#  before_filter :correct_user, :only => [:edit, :update]
#  before_filter :admin_user,   :only => :destroy
## Need to make a special update action for signup users, with a unique name.  Then use that unique
## name in the second, optional form for signup.  (something like setting the "method" or "action" attribute)
 
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page])
    @title = @user.name
    @link_votes = @user.votes.select {|v| v.votable.class.name == "Link"}
    @no_activity = @user.links.empty? && @user.comments.empty? && @link_votes.empty?
  end
  
  def new
    redirect_to(links_path) if signed_in?
    @user = User.new
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html{ render :action => :edit } 
      else
        format.html{ render :action => :new }
      end
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      if signed_in?
        flash[:success] = "Profile updated."
        redirect_to @user
      else
        redirect_to about_path
      end
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end
  
  def links
    @user = User.find(params[:id])
    @title = "Links Submitted by #{@user.name}"
    @links = @user.links.paginate(:page => params[:page])
  end
  
  def comments
    @user = User.find(params[:id])
    @title = "Comments by #{@user.name}"
    @comments = @user.comments.paginate(:page => params[:page])
  end
  
  def upvoted
    @user = User.find(params[:id])
    @title = "Links Upvoted by #{@user.name}"
    @all_upvoted_links = @user.votes.collect {|v| v.votable if v.votable_type == "Link"}
    @upvoted_links = @all_upvoted_links.paginate(:page => params[:page])
  end
  
  private
        
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end