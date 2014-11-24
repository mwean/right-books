RightBooks::Application.routes.draw do
  get '/*id',
      controller: :pages,
      action: :show,
      as: :page,
      format: false

  root controller: :pages, action: :show, id: 'home'
end
