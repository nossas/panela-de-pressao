ManifesteSe::Application.routes.draw do
  match '/auth/:provider/callback',   :to => 'sessions#create'
  resources :sessions, :only => [:new, :destroy]
  resources :campaigns, :only => [:index, :show, :new, :create] do
    resources :pokes, :only => [:create] do
      collection do
        get :create_from_session
      end
    end
  end
  resources :influencers, :only => [:index, :create]
  root :to => 'campaigns#index'
end
