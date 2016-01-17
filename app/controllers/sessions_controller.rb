class SessionsController < ApplicationController

  before_action :authenticate_user!

  include SessionsHelper

  def new
    @sessions = Session.all
  end

  def create
    date = DateTime.strptime(params[:session_date], "%m/%d/%Y %H:%M %P").to_time

    session = Session.create(
      location: params[:location],
      description: params[:description],
      time: date
      )
    redirect_to "/invitations/#{session.id}/search_users"
  end

  def index
    @sessions = current_user.sessions.order(:time)
    @pending_invitations = Invitation.where("status_id = 2")
  end

  def play
    current_session = Session.find(params[:id])
    @session_id = current_session.id
    @available_songs = all_common_songs(current_session)
    @styles = Song.sort_by_style(@available_songs)
    if params[:style]
      @available_songs = Song.sort_by_style(@available_songs)[params[:style]]
    end 

  end

end
