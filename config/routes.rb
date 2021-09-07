Rails.application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      get 'news', to: 'tweets#news'
      get ':date1/:date2', to: 'tweets#date_filter'
      post 'create', to: 'tweets#create'
    end
  end


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users #ruta devise
  delete 'like/:id', to: 'likes#destroy', as:'like_destroy'#ruta para destruir los like
  
  resources :tweets do#ruta anidada para tweets y likes
    resources :likes
  end
  
  get 'home/index'

#ruta anidad para el quote
  resources :users do
    member do
      get 'quote', to: "tweets#quote", as:"quote"
    end
    resources :tweet
  end

  post 'follows/:id', to: 'follows#to_follow', as: 'follow'
  delete 'follows/:id', to: 'follows#to_unfollow', as: 'unfollow'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root'tweets#index' #root
end
