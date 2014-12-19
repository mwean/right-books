RightBooks::Application.routes.draw do
  resources :books, only: :show do
    member { post :comment }
  end

  resources :categories, only: :show

  resources :users, only: :create do
    collection { get :email }
  end

  get :new_releases, controller: :books, action: :new_releases

  get :sign_up, controller: :users, action: :new

  get :sign_in, controller: :sessions, action: :new
  post :sign_in, controller: :sessions, action: :create
  get :sign_out, controller: :sessions, action: :destroy

  get '/*id',
      controller: :pages,
      action: :show,
      as: :page,
      format: false

  root controller: :homes, action: :index
end
