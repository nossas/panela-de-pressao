ManifesteSe::Application.routes.draw do

  match '/auth/:provider/callback',   :to => 'sessions#create'
  resources :sessions, :only => [:destroy]
  resources :organizations, only: [:new, :index, :show, :create]
  resources :campaigns, :only => [:index, :show, :new, :create, :edit, :update] do
    put :accept, :to => "campaigns#accept"
    resources :posts, :only => [:create, :index, :destroy]
    resources :pokes, :only => [:create] do
      collection do
        get :create_from_session, :to => "pokes#create"
      end
    end
  end
  resources :influencers, :only => [:index, :create]
  root :to => 'campaigns#index'
end
