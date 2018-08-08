QuickLogin::Engine.routes.draw do
  post '/login', to: 'login#login', as: :login
end
