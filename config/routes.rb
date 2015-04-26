MaxMusic::Application.routes.draw do

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root
  resources :songs, only: [:new, :create, :index] 

  
   root 'static_pages#home'
   match '/show', to: 'songs#show', via: 'get'
   match '/upload', to: 'songs#upload', via: 'post'
   match '/update', to: 'songs#update', via: 'post'
   match '/destroy', to: 'songs#destroy', via: 'post'
   match '/contact', to: 'static_pages#contact', via: 'get'
   match '/music_training', to: 'static_pages#training', via: 'get'
   match '/getting_started', to: 'static_pages#getting_started', via: 'get'
   match '/about', to: 'static_pages#about', via: 'get'
   match '/edit', to: 'songs#edit', via: 'get'

   match "music_training/*path" => redirect("/music_training?goto=%{path}") , via: 'get'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
