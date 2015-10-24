Rails.application.routes.draw do

  resources :access_codes

  resources :subjects

  resources :questions

  resources :polls

  devise_for :students, controllers: { confirmations: 'confirmations' }
    devise_for :lecturers, controllers: { confirmations: 'confirmations' }
  root :to  => 'ovs_core#index'
  match 'about', :to => 'ovs_core#about', via: :get
  match 'vote', :to => 'ovs_core#vote', via: :get
  match 'history', :to => 'ovs_core#history', via: :get
  match 'choose_question', :to => 'ovs_core#choose_question', :via => :all
  match 'view_questions', :to => 'ovs_core#view_questions', via: :get
  match 'create_poll', :to => 'ovs_core#create_poll', via: :get
  match 'admin', :to => 'ovs_core#adminLogin', via: :get
  match 'view_questions', :to => 'questions#view_questions', :via => :all
  match 'submit_answer', :to => 'questions#submit_answer', :via => :all
  match 'check_code', :to => 'polls#check_code', :via => :all
  match 'final_page', :to => 'questions#final_page', :via => :all
  match 'enter_access_code', :to => 'polls#enter_access_code', :via => :all
  match 'enter_access_code_question', :to => 'questions#enter_access_code_question', :via => :all
  match 'check_code_question', :to => 'questions#check_code_question', :via => :all
  match 'enable_question', :to => 'questions#enable_question', :via => :all
  match 'view_responses', :to => 'questions#view_responses', :via => :all
  match 'poll_questions', :to => 'polls#poll_questions', :via => :all
  match '*unmatched_route', :to => 'ovs_core#page_not_found', :via => :all


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
