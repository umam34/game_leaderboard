Rails.application.routes.draw do
  get '/leaderboard', to: 'scores#leaderboard'
  resources :scores, only: [:index, :create]
end