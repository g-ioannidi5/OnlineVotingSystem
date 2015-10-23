class LecturerRegistrationsController < Devise::RegistrationsController

  def create
    email = params[:lecturer][:email]
    whitelist = Whitelist.where('email = ?', email).first

     if email =~ /[a-z](.)[a-z]{2,}@surrey.ac.uk/i
         super
     else
         flash[:notice] = "You dont have permission to this page"
         redirect_to root_path
     end
  end
end