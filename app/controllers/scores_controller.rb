class ScoresController < ApplicationController
  # GET /leaderboard
  def leaderboard
    @scores = Score.all

    # Filtering by name
    @scores = @scores.where("player_name ILIKE ?", "%#{params[:name]}%") if params[:name].present?

    # Filtering by score
    @scores = @scores.where("score >= ?", params[:min_score].to_i) if params[:min_score].present?
    @scores = @scores.where("score <= ?", params[:max_score].to_i) if params[:max_score].present?

    # Filtering by submitted_at range
    if params[:start_date].present? && params[:end_date].present?
      begin
        start_date = DateTime.strptime(params[:start_date], "%d/%m/%Y")
        end_date = DateTime.strptime(params[:end_date], "%d/%m/%Y")
        @scores = @scores.where(submitted_at: start_date..end_date)
      rescue ArgumentError
        return render json: { error: "Invalid date format. Please use DD/MM/YYYY." }, status: :unprocessable_entity
      end
    end

    # Order by score and limit to top 10
    @scores = @scores.order(score: :desc).limit(10)

    render json: @scores
  end

  # POST /scores
  def create
    @score = Score.new(score_params)
    if @score.save
      render json: @score, status: :created
    else
      render json: @score.errors, status: :unprocessable_entity
    end
  end

  private

  def score_params
    params.permit(:player_name, :score)
  end
end