RightBooks::Application.routes.draw do
  resources :books, only: :show
  resources :categories, only: :show
  get :new_releases, controller: :books, action: :new_releases

  get '/*id',
      controller: :pages,
      action: :show,
      as: :page,
      format: false

  root controller: :homes, action: :index
end
