class UsersController < ApplicationController
  respond_to :turbo_stream

  def show
    @user = User.find(params[:id])
    @matches = Match.where("winner = :user OR loser = :user", user: @user.nickname)
    @matches_user = Match.where(user_id: @user)
    @request_user = Request.where(user_id: @user)
    members = Membership.where(user_id: @user)
    @leagues = []
    members.each do |member|
      @leagues << member.league
    end
  end

  def challenge
    @challenged_user = User.find(params[:id])
    @match = Match.new({
      address: "Guanambi, Brasil",
      match_type: "Desafio",
      modality: "Simple",
      price: "10",
      level: "500",
      date: DateTime.now
    })
    @match.user = @challenged_user
    @match.save
    @request = Request.new(status: 0, match_id: @match.id, user_id: current_user.id)
    @request.save
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
  end

end
