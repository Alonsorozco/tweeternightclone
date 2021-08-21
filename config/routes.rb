Rails.application.routes.draw do
  devise_for :users
  delete 'like/:id', to: 'likes#destroy', as:'like_destroy'
  resources :tweets do
    resources :likes
  end
  get 'home/index'

  resources :users do
    member do
      get 'quote', to: "tweets#quote", as:"quote"
    end
    resources :tweet
  end

  
 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root'tweets#index'
end
