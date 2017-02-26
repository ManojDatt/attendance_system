Rails.application.routes.draw do
	root 'price_list#index'
	resources :price_list , param: :pklist
	
end
