Rails.application.routes.draw do
    root to: 'landing#index'
    get :about, to: 'static_pages#about'
    mount ActionCable.server => '/cable'
    resources :topics, except: [:show] do
        resources :posts, except: [:show] do
            resources :comments, except: [:show]
        end
    end
    resources :users, only: [:new, :edit, :create, :update]
    resources :sessions, only: [:new, :create, :update, :destroy]
    resources :password_resets, only: [:new, :create, :edit, :update]
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
