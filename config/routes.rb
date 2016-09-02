Rails.application.routes.draw do

  root 'messages#index' ## root route (AKA "/") displays the message board main page

  ################# SESSIONS ####################

  get 'login' => 'sessions#new' ## This displays the log in page
  
  post 'sessions' => 'sessions#create' ## This "creates" a new session when user logs in (AKA login route)

  delete 'sessions' => 'sessions#destroy' ## This "deletes" an existing session when user logs out (AKA logout route)

  ################# USERS ####################

  get 'registration' => 'users#new' ## This displays the registration page

  post 'users' => 'users#create' ## This creates a new user in the users table (User model)

  get 'users/:id' => 'users#show' ## This shows a particular user's profile, which is then available for updating and deleting. ":id" refers to user id

  patch 'users/:id' => 'users#update' ## This updates a user's info. ":id" refers to user id

  delete 'users/:id' => 'users#destroy' ## This routes to the method that deletes the user from the users table (User model). ":id" refers to user id

  ################### MESSAGES #####################

  post 'messages/sort' => 'messages#sort'

  get 'messages/:message_id' => 'messages#show' ## This shows a particular post. ":message_id" should only be post. Show not enabled for comments.

  post "messages" => 'messages#create_post' ## This creates a new post (message with no parent)

  post 'messages/:parent_id' => 'messages#create_comment' ## This creates a new comment (message with parent. Parent can be post or comment)

  delete 'messages/:message_id' => 'messages#destroy' ## This deletes a particular message. Only the owner of message may delete.

  ################### LIKES #####################

  post 'likes/:message_id' => 'likes#create' ## This creates a new like. This is mapped to the "Like" button

  delete 'likes/:message_id' => 'likes#destroy' ## This deletes an existing like. This is mapped to the "Unlike" button


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
