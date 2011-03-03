class VotesController < ApplicationController
  before_filter :authenticate
  
  def create
    @votable = Vote.new(params[:vote]).votable
    current_user.vote_for!(@votable)
    
    ## would be more elegant to simply redirect to where user came from,
    ## perhaps by using something like session[:origin]
    if params[:vote][:votable_type] == "Link"
      redirect_to links_path  #stay on links page
    else
      redirect_to Link.find(@votable.link_id)   #stay on link discussion page
    end
  end
  
  def destroy
    #currently no way to destroy a vote
  end
  
  private
  
    def find_votable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end  
      return nil
    end
end