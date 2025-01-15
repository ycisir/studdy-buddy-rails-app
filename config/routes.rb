Rails.application.routes.draw do
  
  root to: "rooms#index"
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :rooms
  resources :messages

  post "search", to: "search#index", as: "search"
  post "search/suggestions", to: "search#suggestions", as: "search_suggestions"
 

  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

end
