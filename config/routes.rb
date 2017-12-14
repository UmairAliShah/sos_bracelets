Rails.application.routes.draw do

  devise_for :users, path: 'auth_users'
  # eg. http://localhost:3000/auth_users/sign_in
  devise_for :admins, path: 'authenticate_sos_admins'
  # eg. http://localhost:3000/auth_admins/sign_in
  devise_for :teams, path: 'auth_teams'
  # eg. http://localhost:3000/auth_teams/sign_in

  resources :team_profiles
  resources :user_profiles do
    member do
      get :show_user_profile
    end
  end
  resources :leaders do
    member do
      get :show_leader
    end
  end
  resources :homes, only: [:index]
  resources :invitations do
    member do
      get :send_invite
    end
  end

  authenticated :team do
    root :to => 'team_profiles#index'
  end
  authenticated :user do
    root :to => 'team_profiles#index'
  end
  authenticated :admin do
    root :to => 'admin/stocks#index'
  end

  namespace :admin do
    resources :stocks
    resources :bloods
    resources :genders
    resources :eyes
    resources :hairs
    resources :heights
  end

  root 'homes#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
