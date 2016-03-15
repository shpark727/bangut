Rails.application.routes.draw do
  root 'home#index'

  
  get 'abcd' => 'home#abcd'
	post 'abcd' => 'home#abcd'

	post 'signup' => 'home#signup'
	post 'signin' => 'home#signin'
  get 'signout' => 'home#signout'
  

	post 'user' => 'home#user'
	post 'edit_user' =>'home#edit_user'
	post 'edit_pw' => 'home#edit_pw_user'
	post 'find_pw' => 'home#find_pw_user'
	get 'terms' => 'home#terms'
	get 'post_list' => 'home#post_list'
	get 'post_detail/:wanted_board_id' => 'home#post_detail'
	get 'post_sort' => 'home#post_sort'
	post 'create_post' => 'home#create_post'
	post 'edit_post/:wanted_board_id' => 'home#edit_post'
	post 'delete_post/:wanted_board_id' => 'home#delete_post'
	get 'answer_post/:wanted_board_id/:wanted_reply' => 'home#answer_post'
	post 'create_reply/:wanted_board_id' => 'home#create_reply'
	post 'edit_reply/:reply_id' => 'home#edit_reply'
	post 'delete_reply/:reply_id' => 'home#delete_reply'
	post 'mypage_post' => 'home#mypage_post'
	post 'mypage_reply' => 'home#mypage_reply'
	get 'notice' => 'home#notice'
	get 'version' => 'home#versions'
	post 'image_upload' => 'home#image_upload'
	get 'fb_share/' => 'home#fb_share'
	post 'pay' => 'home#pay'
	get 'pay' => 'home#pay'




  get 'auth/:provider/callback', to: 'home#fb_create'    #facebook login routing the omniauth callback
  get 'auth/failure', to: 'home#index'
  post 'logout', to: 'home#fb_destroy'           # facebook logout routing the omniauth callback

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
