Rails.application.routes.draw do
  devise_for :users,   controllers: { omniauth_callbacks: 'callbacks' }

  resources :profiles, controller: 'profiles',   only: [:index, :show, :new, :update, :edit, :create]
  resources :users,    controller: 'user_admin', only: [:index, :show, :new, :update, :edit]
  patch '/user/:id/sync_repos', to: 'user_admin#sync_repos', as: :user_sync_repos

  get '/home', to: 'index#index', as: :home
    
  devise_scope :user do
    authenticated :user do
      root 'index#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end
end
