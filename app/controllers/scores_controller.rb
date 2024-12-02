class ScoresController < ApplicationController
    def leaderboard
      @scores = Score.order(score: :desc).limit(10)
      render json: @scores # Render view secara otomatis, tidak perlu render json: di sini
    end
  
    def index
      @scores = Score.all
      render json: @scores
    end
  
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
      params.require(:score).permit(:player_name, :score)
    end
  end