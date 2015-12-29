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
    redirect_to "/invitations/#{session.id}/search_users"
  end

  def invite
    @invited_users = []
    @session = Session.find(params[:id])

    params[:users].each do |member_id|
      unless Invitation.find_by(session_id: params[:id], sender_id: current_user.id, user_id: member_id)
      Invitation.create(
        session_id: params[:id],
        sender_id: current_user.id,
        user_id: member_id,
        status_id: 1
        )
      end

      invitations = []
      invitations = Invitation.where("session_id = #{params[:id]}")
      invitations.each do |invitation|
        @invited_users << User.find(invitation.user_id)
      end
    end

    UserSession.create(
      user_id: current_user.id,
      session_id: params[:id],
      admin: true
      )

    render "invitations/#{params[:id]}/search_users"
  end

  def send_invitations
    session_id = params[:id]
    invitations = []
    invitations = Invitation.where("session_id = #{params[:id]}")

    invitations.each do |invitation|
      invitation.update(status_id: 2)
    end
    redirect_to "/sessions/#{params[:id]}/play"
  end

  def invitations
    @invitations = current_user.invitations.where("status_id = 2")
  end

  def index
    @sessions = current_user.sessions.all
  end

  def play
    current_session = Session.find(params[:id])
    @available_songs = []

    current_user.songs.each do |song|
      add_song = true
      current_session.users.each do |user|
        unless user.songs.exists?(song.id)
          add_song = false
        end
      end
      if add_song
        @available_songs << song
      end
    end
  end

end
