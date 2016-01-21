class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  layout :layout_by_resource

  def authenticate_user!
    unless current_user
      redirect_to '/users/sign_in'
    end
  end


  protected

  def layout_by_resource
    if devise_controller?
      "devise"
    else
      "application"
    end
  end

end
