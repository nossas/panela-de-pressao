ManifesteSe::Application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :influencers, only: [:none] do
        collection do
          get :search, to: "influencers#search"
        end
      end
    end
  end

  get '/auth/:provider/callback', :to => 'sessions#create'
  get '/auth/facebook', as: :facebook_connect
  get '/auth/facebook_admin', as: :facebook_admin_connect

  get "/campaigns/unmoderated", :to => "campaigns#unmoderated", :as => :unmoderated_campaigns
  get "/campaigns/reported", :to => "campaigns#reported", :as => :reported_campaigns

  resources :organizations, only: [:index] do
    resources :campaigns, only: [:index]
  end

  resources :sessions, :only => [:destroy]
  resources :campaigns, :except => [:destroy] do
    member do
      get :map,         defaults: { section: "map" },          as: :map,           to: "campaigns#show"
      get :answers,     defaults: { section: "answers" },      as: :answers,       to: "campaigns#show"
      get :updates,     defaults: { section: "updates" },      as: :updates,       to: "campaigns#show"
    end

    put :accept, :to => "campaigns#accept"
    put :finish, :to => "campaigns#finish"
    put :feature, to: "campaigns#feature"
    put :moderate, to: "campaigns#moderate"
    put :archive, to: "campaigns#archive"

    resources :reports, :only => [:create]
    resources :posts, :only => [:create, :index, :destroy]
    resources :updates, :only => [:show, :new, :create, :edit, :update, :destroy]
    resources :pokes, :only => [:create, :index] do
      collection do
        get :create_from_session, :to => "pokes#create"
      end
    end
    resources :answers, :only => [:create, :destroy]
  end

  resources :influencers, except: [:destroy] do
    member do
      patch :archive, to: "influencers#archive"
    end
  end

  resources :users, only: [:index] do
    resources :campaigns, :only => [:index]
    get :autocomplete_user_email, :on => :collection
  end

  get '/explore', to: "campaigns#explore", as: :explore
  get '/about', to: "pages#about", as: :about

  match '/404', to: 'errors#not_found', via: :all

  root :to => 'campaigns#index'
end
