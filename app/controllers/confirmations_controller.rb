class ConfirmationsController < Devise::ConfirmationsController

  private

  def after_confirmation_path_for(resource_name, resource)
    redirect_to "http://www.onlinevotingsystem.net"
  end

end