class SessionsController < ApplicationController

  before_action :authenticate_user!

  include SessionsHelper

  def new
  end

  def create
    datetime_hash = params[:session_datetime]
    session = Session.create(
      location: params[:location],
      description: params[:description],
      time: datetime_hash[:datetime]
      )
    redirect_to "/invitations/#{session.id}/search_users"
  end

  def index
    @sessions = current_user.sessions.all
  end

  def play
    current_session = Session.find(params[:id])
    @available_songs = all_common_songs(current_session)
    
  end

end
