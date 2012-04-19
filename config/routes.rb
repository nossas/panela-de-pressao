ManifesteSe::Application.routes.draw do
  match '/auth/:provider/callback',   :to => 'sessions#create'
  resources :campaigns, :only => [:index]
  root :to => 'issues#new'
end
