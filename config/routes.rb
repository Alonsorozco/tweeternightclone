Rails.application.routes.draw do
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

  

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root'tweets#index' #root
end
