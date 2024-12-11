# config/application.rb

module GameLeaderboard
    class Application < Rails::Application
      # ...
      config.middleware.insert_before 0, Rack::Cors do
        allow do
          origins 'http://localhost:3001' # Sesuaikan dengan URL frontend
          resource '*',
                   headers: :any,
                   methods: [:get, :post, :put, :patch, :delete, :options, :head]
        end
      end
    end
  end