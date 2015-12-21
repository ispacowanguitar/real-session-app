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
    @users = User.where('email LIKE? OR first_name LIKE? OR last_name LIKE?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
    end
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

    render "search_users"
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

  # def add_members_to_session
  #   session_id = params[:id]
  #   @session = Session.find(session_id)
  #   if params[:users]
  #     @member_ids = params[:users]
  #     @member_ids << current_user.id
  #     @member_ids.each do |member_id|
  #       unless UserSession.find_by(user_id: member_id, session_id: session_id)
  #         if current_user.id == member_id
  #           admin = true
  #         else 
  #           admin = false
  #         end
  #       UserSession.create(
  #         user_id: member_id,
  #         session_id: session_id,
  #         admin: admin
  #         )
  #       end
  #     end
  #   end
  #     @band_members = Session.find(params[:id]).users

  #   render 'search_users'
  # end

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
