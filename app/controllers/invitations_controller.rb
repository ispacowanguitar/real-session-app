class InvitationsController < ApplicationController

    before_action :authenticate_user!


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

    if params[:users]
      params[:users].each do |member_id|
        unless Invitation.find_by(session_id: params[:id], sender_id: current_user.id, user_id: member_id) || (member_id.to_i == current_user.id)
          Invitation.create(
            session_id: params[:id],
            sender_id: current_user.id,
            user_id: member_id,
            status_id: 1
            )
        end
    end



      invitations = []
      invitations = Invitation.where("session_id = #{params[:id]}")
      invitations.each do |invitation|
        @invited_users << User.find(invitation.user_id)
      end
    end
    

    render "search_users"
  end

  def send_invitations
    session_id = params[:id]
    unless UserSession.find_by(user_id: current_user.id, session_id: session_id)
      UserSession.create(
        user_id: current_user.id,
        session_id: session_id,
        admin: true
        )
    end
    invitations = []
    invitations = Invitation.where("session_id = #{params[:id]}")


    invited_names = []
    invitations.each do |invitation|
      invitation.update(status_id: 2)
      invited_names << "#{invitation.user.full_name}"
    end

    invited_names.insert(invited_names.length - 1, " and")
    invited_names = invited_names.join(", ")

    flash[:success] = "Invitations successfully sent to #{invited_names}!"
    redirect_to "/sessions"
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
      unless UserSession.find_by(user_id: current_user.id, session_id: invitation.session.id)
        UserSession.create(
          user_id: current_user.id,
          session_id: invitation.session.id,
          admin: false
          )
      end
      flash[:success] = "You have accepted the invitation to play with #{User.find(invitation.sender_id).full_name} at #{invitation.session.location}"
    elsif params[:response] == "decline"
      invitation.update(status_id: 3)
      flash[:info] = "You have declined this invitation"
    end

    redirect_to "/invitations"
  end

end
