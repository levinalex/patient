ActionController::Routing::Routes.draw do |map|
  map.resources :notes

  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.resources :user_sessions, :as => "try_again"

  map.resources :users
  map.profile "profile", :controller => "users", :action => "edit"
  map.resources :doctors, :only => :index

  map.resources :patients, :shallow => true do |patient|
    patient.resources :accessions do |accession|
      accession.resources :results
    end
  end
  
  map.resources :accessions, :only => :index, :member => { :report => :put, :edit_results => :get }
  map.admin "admin", :controller => "admin/users", :action => "index"

  map.namespace :admin do |admin|
    admin.resources :users
    admin.resources :doctors
    admin.resources :insurance_providers
    admin.resources :panels
    admin.resources :lab_test_values
    admin.resources :lab_test_value_options
    admin.resources :reference_ranges
    admin.resources :lab_tests, :collection => { :sort => :put }
    admin.resources :units
    admin.resources :departments
  end

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"
  map.root :patients

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
