Hellopromo::Application.routes.draw do
  resources :shares, :except => :index do
    resources :redeemables, :only => :destroy
    
    member do
      get '/acquire' => 'redeemables#acquire', :as => 'acquire'
      post '/redeem' => 'redeemables#redeem', :as => 'redeem'
    end
  end
  
  get '/signin' => redirect('/auth/twitter'), :as => 'signin'
  get '/signout' => 'sessions#destroy', :as => 'signout'
  match '/auth/twitter/callback' => 'sessions#create' 
  match '/auth/failure' => 'sessions#failure'
  
  get '/profile' => 'pages#profile', :as => 'profile'
  root :to => 'pages#index'
end
