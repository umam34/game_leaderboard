class LeaderboardsController < ApplicationController
  def index
    leaderboards = Leaderboard.all

    # Filtering by player_name
    leaderboards = leaderboards.where("player_name ILIKE ?", "%#{params[:name]}%") if params[:name].present?

    # Filtering by minimum and maximum score
    leaderboards = leaderboards.where("score >= ?", params[:min_score]) if params[:min_score].present?
    leaderboards = leaderboards.where("score <= ?", params[:max_score]) if params[:max_score].present?

    # Filtering by date range
    if params[:start_date].present? && params[:end_date].present?
      leaderboards = leaderboards.where(submitted_at: params[:start_date]..params[:end_date])
    end

    # Urutkan berdasarkan score tertinggi dan batasi 10 data
    render json: leaderboards.order(score: :desc).limit(10)
  end
end