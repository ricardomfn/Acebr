class MatchesController < ApplicationController

  def index
    @matches = Match.order(date: :desc, level: :asc)

    if params[:address].present?
      @matches = @matches.where("address ILIKE ?", "%#{params[:address]}%")
    end

    if params[:date].present?
      @matches = @matches.select { |m| m.date.to_date == Date.parse(params[:date]) }
      @matches = Match.where(id: @matches.map(&:id))
    end

    @markers = @matches.geocoded.map do |match|
      {
        lat: match.latitude,
        lng: match.longitude
      }
    end
  end

  def show
    @match = Match.find(params[:id])
    @request = Request.new

    if @match.geocoded?
      @markers = [
        {
          lat: @match.latitude,
          lng: @match.longitude
        }
      ]
    end
  end

  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)
    @match.user = current_user
    if @match.save
      redirect_to match_path(@match)
    else
      render new_match_path, status: :unprocessable_entity, alert: 'An error occured'
    end
  end

  def edit
    @match = Match.find(params[:id])
    @request = Request.where(match: @match).first
  end

  def result
    @match = Match.find(params[:id])
    @request = Request.where(match: @match).first
    @match.winner = params[:match][:winner]
    if @match.winner == @match.user.nickname
      @match.loser = @request.user.nickname
    else
      @match.loser = @match.user.nickname
    end
  end

  def update
    result
    @match.update(match_params)
    k_factor = 32 # K-factor determines the magnitude of rating adjustments

    # Calculate the expected scores for the user and opponent
    expected_score_user = 1.0 / (1 + 10**((@request.user.points - @match.user.points) / 400.0))
    expected_score_opponent = 1.0 / (1 + 10**((@match.user.points - @request.user.points) / 400.0))

    # Update the user's rating based on the result
    if @match.winner == @match.user.nickname
      @points_change_user = k_factor * (1 - expected_score_user)
      @points_change_opponent = k_factor * (0 - expected_score_opponent)
      @match.user.points += @points_change_user
      @request.user.points += @points_change_opponent
    else
      @points_change_user = k_factor * (0 - expected_score_user)
      @points_change_opponent = k_factor * (1 - expected_score_opponent)
      @match.user.points += @points_change_user
      @request.user.points += @points_change_opponent
    end

    @match.user.points = [0, @match.user.points].max
    @request.user.points = [0, @request.user.points].max

    @match.user.save
    @request.user.save

    redirect_to profile_path(points_change_user: @points_change_user, points_change_opponent: @points_change_opponent)
  end


  private
  def match_params
    params.require(:match).permit(:address, :modality, :price, :level, :date, :match_type, :winner, :winner_score, :loser_score, :loser)
  end
end
