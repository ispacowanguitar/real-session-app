class SessionsController < ApplicationController


  before_action :authenticate_user!

  def new
  end

  def create
    datetime_hash = params[:session_datetime]
    Session.create(
      location: params[:location],
      description: params[:description],
      time: datetime_hash[:datetime]
      )
  end

  def search_users
    if params[:search]
    @users = User.where('email LIKE?', "%#{params[:search]}%")
    end
  end

  def add_members_to_session
    @members = params[:users]
    render '/sessions/search_users'
  end

end
