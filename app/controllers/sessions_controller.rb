class SessionsController < ApplicationController


  before_action :authenticate_user!

  def new
  end

  def create
    datetime_hash = params[:session_datetime]
    session = Session.create(
      location: params[:location],
      description: params[:description],
      time: datetime_hash[:datetime]
      )
    redirect_to "/sessions/#{session.id}/search_users"
  end

  def search_users
    @session = Session.find(params[:id])
    if params[:search]
    @users = User.where('email LIKE?', "%#{params[:search]}%")
    end
  end

  def add_members_to_session
    session_id = params[:id]
    @session = Session.find(session_id)
    @member_ids = params[:users]
    @member_ids.each do |member_id|
      unless UserSession.find_by(user_id: member_id, session_id: session_id)
      UserSession.create(
        user_id: member_id,
        session_id: session_id
        )
      end
    end
    @band_members = Session.find(params[:id]).users

    render 'search_users'
  end

end
