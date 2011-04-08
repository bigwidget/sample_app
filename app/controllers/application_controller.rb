class ApplicationController < ActionController::Base
  protect_from_forgery
  layout :application_layout
  include SessionsHelper
  
  private
    def application_layout
      signed_in? ? "application" : "landing_page"
    end
end
