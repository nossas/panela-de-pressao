ManifesteSe::Application.routes.draw do

  match '/auth/:provider/callback',   :to => 'sessions#create'
  get '/auth/facebook', as: :facebook_connect
  get '/auth/facebook_admin', as: :facebook_admin_connect

  get "/campaigns/unmoderated", :to => "campaigns#unmoderated", :as => :unmoderated_campaigns
  
  resources :categories, only: [:index] do
    resources :campaigns, only: [:index]
  end
  resources :sessions, :only => [:destroy]
  resources :campaigns, :except => [:destroy] do
    member do
      get :comments,    defaults: { section: "comments" },     as: :comments,      to: "campaigns#show"
      get :map,         defaults: { section: "map" },          as: :map,           to: "campaigns#show"
      get :answers,     defaults: { section: "answers" },      as: :answers,       to: "campaigns#show"
      get :updates,     defaults: { section: "updates" },      as: :updates,       to: "campaigns#show"
    end

    put :accept, :to => "campaigns#accept"
    put :finish, :to => "campaigns#finish"
    put :feature, to: "campaigns#feature"
    put :moderate, to: "campaigns#moderate"
    put :archive, to: "campaigns#archive"

    resources :posts, :only => [:create, :index, :destroy]
    resources :updates, :only => [:show, :new, :create]
    resources :pokes, :only => [:create] do
      collection do
        get :create_from_session, :to => "pokes#create"
      end
    end
    resources :answers, :only => [:create, :destroy]
  end
  resources :influencers, except: [:destroy]

  resources :users, only: [:index] do
    resources :campaigns, :only => [:index]
    get :unsubscribe, :to => "users#unsubscribe"
  end


  get '/explore', to: "campaigns#explore", as: :explore
  get '/about', to: "pages#about", as: :about

  root :to => 'campaigns#index'
end
