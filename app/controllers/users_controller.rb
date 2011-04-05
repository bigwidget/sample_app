class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => :destroy
  
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
    @user = User.new
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to @user, :flash => { :success => "Welcome to the Sample App!"}
    else
      @title = "Sign up"
      render 'new'
    end
  end

  def edit
    @title = "Edit user"
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
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