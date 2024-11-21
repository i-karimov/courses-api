Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  
  namespace :api do
    namespace :v1 do
      resources :authors do
        resources :courses, only: [ :create ]
      end

      resources :courses do
        resources :skills, only: [ :create ]
      end

      resources :skills, only: [ :index, 
    end
  end
end
