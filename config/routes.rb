ManifesteSe::Application.routes.draw do
  match '/auth/:provider/callback',   :to => 'sessions#create'
  resources :campaigns, :only => [:index, :show, :new]
  root :to => 'campaigns#index'
end
