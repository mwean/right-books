RightBooks::Application.routes.draw do
  resources :books, only: :show

  get '/*id',
      controller: :pages,
      action: :show,
      as: :page,
      format: false

  root controller: :homes, action: :index
end
