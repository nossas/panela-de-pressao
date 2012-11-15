ManifesteSe::Application.routes.draw do

  match '/auth/:provider/callback',   :to => 'sessions#create'
  get '/auth/facebook', as: :facebook_connect

  get "/campaigns/unmoderated", :to => "campaigns#unmoderated", :as => :unmoderated_campaigns
  
  resources :categories, only: [:index] do
    resources :campaigns, only: [:index]
  end
  resources :sessions, :only => [:destroy]
  resources :campaigns do
    member do
      get :comments,    defaults: { section: "comments" },     as: :comments,      to: "campaigns#show"
      get :map,         defaults: { section: "map" },          as: :map,           to: "campaigns#show"
      get :answers,     defaults: { section: "answers" },      as: :answers,       to: "campaigns#show"
    end

    put :accept, :to => "campaigns#accept"
    put :finish, :to => "campaigns#finish"
    put :feature, to: "campaigns#feature"

    resources :posts, :only => [:create, :index, :destroy]
    resources :pokes, :only => [:create] do
      collection do
        get :create_from_session, :to => "pokes#create"
      end
    end
    resources :answers, :only => [:create]
  end
  resources :influencers, except: [:destroy]

  resources :users, only: [:show, :update, :index] do
    resources :campaigns, :only => [:index]
  end


  get '/explore', to: "campaigns#explore", as: :explore
  get '/ajuda' => redirect('http://meurio.org.br/paginas/sobre_nos'), as: :help

  root :to => 'campaigns#index'
end
