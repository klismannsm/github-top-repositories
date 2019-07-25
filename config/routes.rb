# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'github_repositories#index'

  resources :github_repositories, only: [:index, :show] do
    post :import, on: :collection, to: 'github_repositories#import'
    delete :destroy_all, on: :collection, to: 'github_repositories#destroy_all'
  end
end
