Cvsa::Application.routes.draw do



resources :services

root :to => 'Votes#index'




###########votes#######################
get	"votes/index"
	
get 	"votes/authenticate"

get	"votes/serviceselect"

post    "votes/checksat"

post    "votes/assesslevel"

get 	"votes/concerns"

get	"votes/save_vote"

post 	"votes/save_vote"

get	"votes/comment"

post 	"votes/save_comment"

get     "votes/leavecomment"

get    "votes/save_comment"

 

#####################################

get	"Admin/addconcerns"

post	"Admin/addconcerns"

################### USER ##############################
 # match '/login' => "user#login"

  #match '/logout' => "user#logout"

 # match '/verify_user' => "user#verify_user"

  get "user/index"

  get "user/login"

  get "user/logout"

  get "user/create"

  get "user/edit"

  get "user/edit_user"

  post "user/verify_user"

  post "user/save"

  post "user/delete"

  post "user/save_edit"
















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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id(.:format)))'

end
