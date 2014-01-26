ToptalTest::Application.routes.draw do
  devise_for :users

  resources :tasks, except: [:new, :edit, :show] do
    member do
      post :done
      post :undone
    end
  end

  root to: 'tasks#index'
end
