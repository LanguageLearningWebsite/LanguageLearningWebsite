require 'api_constraints'

Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users

  as :user do
    get 'users', :to => 'devise/registrations#new'
  end

  get 'pages/about'
  get 'pages/record'

  get '/mycourses' => 'course#list'
  post '/enroll' => 'enroll#enroll'

  root 'course#index'

  resources :course do
    resources :lesson, only: [:show] do
      resources :component, only: [:show]
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      get '/translate' => 'translate#show'
      get '/aws_presigned_url' => 'aws#presigned_url'
    end
  end
end
