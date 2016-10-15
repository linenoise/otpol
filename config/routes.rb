Rails.application.routes.draw do

  ### Landings

  get 'landings/index'
  root 'landings#index'

  ### People

  resources :people, only: [:show, :edit, :update]

  ### Points

  resources :points do
    member do
      get :like
      get :unlike
    end
  end

  ### Authentication

  devise_for :users, controllers: {registrations: "users/registrations", sessions: "users/sessions", passwords: "users/passwords"}, skip: [:sessions, :registrations]
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_scope :user do
    get    "login"   => "users/sessions#new",             as: :new_user_session
    post   "login"   => "users/sessions#create",          as: :user_session
    delete "signout" => "users/sessions#destroy",         as: :destroy_user_session
    
    get    "signup"  => "users/registrations#new",        as: :new_user_registration
    post   "signup"  => "users/registrations#create",     as: :user_registration
    put    "signup"  => "users/registrations#update",     as: :update_user_registration
    get    "account" => "users/registrations#edit",       as: :edit_user_registration
  end

  ### Administration

  ActiveAdmin.routes(self)
  
  ### Relationships

  get 'rel/block/:id',     to: 'relationships#block',     as: 'block_user'
  get 'rel/unblock/:id',   to: 'relationships#unblock',   as: 'unblock_user'
  get 'people/:id/blocked',to: 'people#blocked',          as: 'block_list'
  get 'rel/follow/:id',    to: 'relationships#follow',    as: 'follow_user'
  get 'rel/unfollow/:id',  to: 'relationships#unfollow',  as: 'unfollow_user'

  ### RSS
  
  get 'feed' => 'points#feed'

  ### Legal

  get 'legal/privacy',     to: "legal#privacy",           as: 'legal_privacy'
  get 'legal/terms',       to: 'legal#terms',             as: 'legal_terms'

  ### Guides

  get 'guide/api',         to: 'guide#api',               as: 'api_guide'
  get 'guide/about',       to: 'guide#about',             as: 'about_guide'
  get 'guide/contact',     to: 'guide#contact',           as: 'contact_guide'
  get 'guide/welcome',     to: 'guide#welcome',           as: 'welcome_guide'

end
