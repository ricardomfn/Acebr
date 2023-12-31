class LeaguesController < ApplicationController
  before_action :authenticate_user!

  # GET /leagues
  def index
    @leagues = League.all
  end

  # GET /leagues/1
  def show
    @league = League.find(params[:id])
    @ordered_members = @league.memberships.sort_by { |membership| -membership.user.points }
  end

   # GET /leagues/new
  def new
    @league = League.new
  end

  def edit
  end

  # POST /gardens
  def create
    @league = League.new(league_params)
    @league.user = current_user

    if @league.save
      redirect_to new_league_membership_path(@league), notice: "League was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
    @league = League.find(params[:id])
    @league.destroy
    redirect_to profile_path, notice: "League deleted successfully."
  end


  private

  def league_params
    params.require(:league).permit(:name, :image)
  end


end
