# rubocop:disable Lint/MissingCopEnableDirective, Metrics/BlockLength
Rails.application.routes.draw do
  draw(:redirects)
  ActiveAdmin.routes(self)

  require 'sidekiq/web'
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  if Rails.env.development?
    mount Lookbook::Engine, at: '/lookbook'
  end

  resource :github_webhooks, only: :create, defaults: { formats: :json }

  unauthenticated do
    root 'static_pages#home'
  end

  authenticated :user do
    root to: redirect('/dashboard'), as: :authenticated_root
  end

  devise_for(
    :users,
    module: 'users',
    controllers: { passwords: 'users/password_resets' },
    path_names: { password: 'password_reset' }
  )

  devise_scope :user do
    get '/sign_in' => 'users/sessions#new'
    get '/sign_out' => 'users/sessions#destroy', method: :delete
    get '/sign_up' => 'users/registrations#new'
  end

  namespace :api do
    resources :lesson_completions, only: [:index]
    resources :points, only: %i[index show create]
  end


  get 'blog/1' => 'static_pages#blog1'
  get 'blog/2' => 'static_pages#blog2'
  get 'blog/3' => 'static_pages#blog3'
  get 'blog/4' => 'static_pages#blog4'

  get 'job/1' => 'static_pages#job1'
  get 'job/2' => 'static_pages#job2'
  get 'job/3' => 'static_pages#job3'
  get 'job/4' => 'static_pages#job4'


  get '/storie/musa' => 'static_pages#musa'
  get '/storie/ceci' => 'static_pages#ceci'
  get '/storie/baraka' => 'static_pages#baraka'
  get '/storie/elizabeth' => 'static_pages#elizabeth'
  get '/storie/kelvin' => 'static_pages#kelvin'
  get '/storie/carlos' => 'static_pages#carlos'

  get 'home' => 'static_pages#home'
  get 'about' => 'static_pages#about'
  get 'orientation' => 'static_pages#orientation'
  get 'outcomes' => 'static_pages#outcomes'
  get 'blog' => 'static_pages#blog'
  get 'job_placement' => 'static_pages#job_placement'
  get 'faq' => 'static_pages#faq'
  get 'contributing' => 'static_pages#contributing'
  get 'terms_of_use' => 'static_pages#terms_of_use'
  get 'success_stories' => 'static_pages#success_stories'
  get 'community_rules' => 'static_pages#community_rules'
  get 'community_expectations' => 'static_pages#community_expectations'
  get 'before_asking' => 'static_pages#before_asking'
  get 'how_to_ask' => 'static_pages#how_to_ask'
  get 'sitemap' => 'sitemap#index', defaults: { format: 'xml' }

  # failure route if github information returns invalid
  get '/auth/failure' => 'omniauth_callbacks#failure'
  get 'dashboard' => 'users#show', as: :dashboard

  namespace :users do
    resources :paths, only: :create
    resources :progress, only: :destroy
    resource :profile, only: %i[edit update]
  end

  namespace :lessons do
    resource :preview, only: %i[show create] do
      post :markdown
    end

    resources :installation_guides, only: :index
  end

  namespace :courses do
    resources :progress, only: %i[show]
  end

  resources :lessons, only: :show do
    resources :project_submissions, only: %i[index], controller: 'lessons/project_submissions'
    resource :completion, only: %i[create destroy], controller: 'lessons/completions'
  end

  resources :project_submissions do
    resources :flags, only: %i[create], controller: 'project_submissions/flags'
    resources :likes, controller: 'project_submissions/likes'
  end

  resources :paths, only: %i[index show] do
    resources :courses, only: :show
  end

  resources :notifications, only: %i[index update]
  resource :themes, only: :update

  match '/404' => 'errors#not_found', via: %i[get post patch delete]
end
