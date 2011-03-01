class VotesController < ApplicationController
  before_filter :authenticate
  
  def create
    @link = Link.find(params[:vote][:link_id])
    current_user.vote_for!(@link)
    redirect_to links_path
  end
  
  def destroy
    #currently no way to destroy a vote
  end
end