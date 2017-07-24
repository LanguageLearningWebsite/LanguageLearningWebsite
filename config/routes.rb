require 'api_constraints'

Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  as :user do
    get 'users', :to => 'devise/registrations#new'
  end

  root 'courses#index'

  get 'pages/about'
  get 'pages/record'
  get '/mycourses' => 'courses#list'
  post '/enroll' => 'enrolls#enroll'
  delete 'attempts/:survey_id/:user_id' => 'attempts#delete_user_attempts', as: :delete_user_attempts

  resources :courses do
    resources :lessons, only: [:show] do
      resources :components, only: [:show] do
        resources :attempts
      end
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      get '/translate' => 'translate#show'
      get '/aws_presigned_url' => 'aws#presigned_url'
      get '/recordings/new' => 'recordings#new'
      get '/recordings/submit' => 'recordings#submit'
    end
  end
end
