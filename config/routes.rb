ManifesteSe::Application.routes.draw do
  match '/auth/:provider/callback',   :to => 'sessions#create'
  root :to => 'issues#new'
end
