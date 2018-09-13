Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :videos, only: [:show, :create, :new, :index, :edit, :update] do
    resources :comments, only: [:create, :destroy, :update]
    resources :video_likes, only: [:create, :destroy, :update]
    collection do
      get 'search'
      get 'hour'
      get 'today'
      get 'week'
      get 'month'
      get 'year'
      get 'up'
      get 'count'
      get 'rank'
    end
  end
  resources :watches, only:[:index, :destroy]
  root 'videos#index'
end
