Rails.application.routes.draw do
  namespace :api do
    namespace :v0 do
      get '/courses', to: 'courses#index'
      post '/courses', to: 'courses#create'
    end
  end
end
