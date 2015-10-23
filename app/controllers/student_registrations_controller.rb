class StudentRegistrationsController < Devise::RegistrationsController

  def create
    email = params[:student][:email]
        if email =~ /[a-z]{2}[0-9]{5}@surrey.ac.uk/
            flash[:notice] = "Welcome! You have signed up successfully."
            super 
        else
            flash[:alert] = "Invalid email address"
            redirect_to new_student_registration_path
             
        end
  end
end