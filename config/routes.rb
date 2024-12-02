Rails.application.routes.draw do
  post '/scores', to: 'scores#create'
  get '/leaderboard', to: 'scores#leaderboard'
  
  resources :scores, only: [:index, :create]
end
