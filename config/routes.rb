Rails.application.routes.draw do
  devise_for :users,   controllers: { omniauth_callbacks: 'callbacks' }

  resources :profiles, controller: 'profiles', only: [:index, :show, :new, :update, :edit, :create]
  patch '/profile/:id/publish', to: 'profiles#publish', as: :profile_publish
  patch '/profile/:id/deactivate', to: 'profiles#deactivate', as: :profile_deactivate
  get '/welcome', to: 'profiles#launch', as: :profile_launch

  resources :users, controller: 'user_admin', only: [:index, :show, :new, :update, :edit]
  patch '/user/:id/sync_repos', to: 'user_admin#sync_repos', as: :user_sync_repos

  devise_scope :user do
    authenticated :user do
      root 'profile#launch', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
