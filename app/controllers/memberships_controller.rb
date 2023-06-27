class MembershipsController < ApplicationController

  def new
    @league = League.find(params[:league_id])
    @users = User.all
    @membership = Membership.new

    if params[:query].present?
      sql_query = "users.nickname ILIKE :query"
      @user_collection = User.where(sql_query, query: "%#{params[:query]}%") - [current_user]
    else
      @user_collection = User.all - [current_user]
    end
    @user_collection = @user_collection - @league.users
  end


  def create
    if params[:membership].present?
      @league = params[:league_id]
      @users = params[:membership][:user].dup

      # Add current_user[:id] if it's not already present
      unless @users.include?(current_user[:id].to_s)
        @users << current_user[:id].to_s
      end

      @users.each do |user|
        existing_membership = Membership.find_by(user_id: user, league_id: @league)
        next if existing_membership

        membership = Membership.new(user_id: user, league_id: @league)
        membership.save
      end

      redirect_to league_path(@league)
    end
  end


  def destroy
    @membership = Membership.find(params[:id])
    @membership.destroy
    redirect_to league_path(@membership.league), status: :see_other
  end

  private

  def render_new
    @membership = Membership.new
    @membership.errors.add(:base, "A selected already exists")
    render :new, status: :unprocessable_entity
  end
end
