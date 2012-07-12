AngelHack::Application.routes.draw do
  devise_for :mentors, controllers: { registrations: 'registrations', sessions: 'sessions', passwords: 'passwords' }

  devise_for :mentees, controllers: { registrations: 'registrations', sessions: 'sessions', passwords: 'passwords' }

  resources :messages

  resources :mentors do
    collection do
      get 'conversations'
      get 'stream'
    end
  end

  resources :tags

  resources :conversations
  
  resources :mentees do
    collection do
      get 'conversations'
    end
  end
  
  namespace :api do
    namespace :v1 do
      post 'tokens/create'
      post 'tokens/destroy'
      get 'conversations/all'
      match 'conversations/:id' => "conversations#show"
      post 'messages/create'
    end
  end
  
  post 'emails/add_email'
  
  match '/apply' => 'apps#apply', via: :get
  match '/apply' => 'apps#create', via: :post
  match '/' => 'mentee_apps#create', via: :post
  
  devise_scope :mentor do
    match '/sign_in' => 'sessions#new'
    match '/new_password' => 'passwords#new'
  end
  
   
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

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
