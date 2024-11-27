require "sidekiq/web"

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  mount Sidekiq::Web => "/jobs"

  namespace :api do
    namespace :v1 do
      resources :authors do
        resources :courses, controller: 'authors/courses',only: [ :show, :create, :update, :destroy ]
      end

      # resources :courses, only: [ :index ] do
      #   resources :skills, only: [ :create, :update ]
      # end


      # resources :skills, only: [ :index, :create, :update, :destroy ]
    end
  end
end
