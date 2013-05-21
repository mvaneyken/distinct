Distinct::Application.routes.draw do
  devise_for :representatives
  devise_for :technicians

  namespace :admin do
    resources :template_actions do
      get :autocomplete_admin_tolerance_action_message, on: :collection
    end
  end
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config
  
  devise_for :representatives
  authenticated :representative do
    namespace :installed_base do
      resources :clients
      resources :installations
    end
  end
  match :installed_base, to: 'pages#landing'
  
  devise_for :technicians
  authenticated :technician do
    namespace :lab do
      post :update_plus_version
      resources :lots do
        resources :lot_versions do
          get :show_results
        end
      end
    end
  end
  match :lab, to: 'pages#landing'
  
  root :to => 'pages#landing', :as => :home
  
end
