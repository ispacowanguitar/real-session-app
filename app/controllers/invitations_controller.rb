class InvitationsController < ApplicationController

  def search_users
    @session = Session.find(params[:id])
    if params[:search]
    @users = User.where('email LIKE? OR first_name LIKE? OR last_name LIKE?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
    end
    render "search_users"
  end

  def create
    @invited_users = []
    @invited_users << current_user
    @session = Session.find(params[:id])

    params[:users].each do |member_id|
      unless Invitation.find_by(session_id: params[:id], sender_id: current_user.id, user_id: member_id) || (member_id.to_i == current_user.id)
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

  def index
    @invitations = []
    @invitations = current_user.invitations.where("status_id = 2")
    if @invitations == nil
      puts "HELLOOOOO"
    end
  end

  def reply
    puts params[:invitation_id]
    puts params[:response]
    invitation = Invitation.find(params[:invitation_id])

    if params[:response] == "accept"
      invitation.update(status_id: 4)
      UserSession.create(
        user_id: current_user.id,
        session_id: invitation.session.id,
        admin: false
        )
    elsif params[:response] == "decline"
      invitation.update(status_id: 3)
    end

    redirect_to "/invitations"
  end

end
