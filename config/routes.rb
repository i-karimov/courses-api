require "sidekiq/web"

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  mount Sidekiq::Web => "/jobs"

  namespace :api do
    namespace :v1 do
      resources :authors do
        resources :courses, only: [ :index, :show, :create, :update, :destroy ], controller: "authors/courses"
      end

      resources :courses, only: [ :index, :show ] do
        resources :skills, only: [ :index, :create, :destroy ], controller: "courses/skills"
      end

      resources :skills, only: [ :index, :create, :destroy ]
    end
  end
end
