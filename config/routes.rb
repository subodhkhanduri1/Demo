Rails.application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
match 'user/login', :to => 'user#login'
match 'user/home', :to => 'user#home'
match 'user/profile', :to => 'user#profile'
match 'user/logout', :to => 'user#logout'
match 'user/sign_up', :to => 'user#sign_up'
match 'user/edit_profile', :to => 'user#edit_profile'
match 'user/change_password', :to => 'user#change_password'
match 'user/change_name', :to => 'user#change_name'
match 'user/view_followers', :to => 'user#view_followers'
match 'user/view_followees', :to => 'user#view_followees'
match 'user/post_tweet', :to => 'user#post_tweet'
match 'user/all_users', :to => 'user#all_users'
match 'follow/create', :to => 'follow#create'
match 'follow/delete', :to => 'follow#delete'
match 'tweet/view_tweets', :to => 'tweet#view_tweets'

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)
=begin
  resource :user do
    member do
      get 'user/login', :to => 'user#login'
      get 'user/home', :to => 'users#home'
      get 'user/logout', :to => 'user#logout'
      get 'user/sign_up', :to => 'user#sign_up'
      get 'user/view_followers', do :view_followers
      end
    end
=end
  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
