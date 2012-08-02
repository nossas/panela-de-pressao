ManifesteSe::Application.routes.draw do

  match '/auth/:provider/callback',   :to => 'sessions#create'
  get '/auth/facebook', as: :facebook_connect
  get '/auth/meurio',   as: :meurio_connect

  resources :sessions, :only => [:destroy]
  resources :campaigns do
    member do
      get :comments,    defaults: { section: "comments" },     as: :comments,      to: "campaigns#show"
      get :map,         defaults: { section: "map" },          as: :map,           to: "campaigns#show"
      get :answers,     defaults: { section: "answers" },      as: :answers,       to: "campaigns#show"
      get :description, defaults: { section: "description" },  as: :description,   to: "campaigns#show"
    end

    put :accept, :to => "campaigns#accept"

    resources :posts, :only => [:create, :index, :destroy]
    resources :pokes, :only => [:create] do
      collection do
        get :create_from_session, :to => "pokes#create"
      end
    end
  end
  resources :influencers, :only => [:index, :create, :show, :new]
  resources :users, only: [:show, :update, :index] do
    resources :campaigns, :only => [:index]
  end
  root :to => 'campaigns#index'
end
