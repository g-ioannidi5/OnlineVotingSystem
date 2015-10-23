class ApplicationController < ActionController::Base
protect_from_forgery :with => :exception
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.





   private

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource)
    root_path
  end
 end



 

