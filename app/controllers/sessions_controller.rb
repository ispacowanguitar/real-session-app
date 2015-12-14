class SessionsController < ApplicationController


  before_action :authenticate_user!

  def search_users
    if params[:search]
    @users = User.where('email LIKE?', "%#{params[:search]}%")
    end
  end

  def create_session
    @members = params[:users]
    
  end

end
