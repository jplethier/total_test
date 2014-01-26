ToptalTest::Application.routes.draw do
  use_doorkeeper

  devise_for :users

  namespace :api do
    resources :tasks, except: [:new, :edit, :show] do
      member do
        post :done
        post :undone
      end
    end
  end

  resources :tasks, except: [:new, :edit, :show] do
    member do
      post :done
      post :undone
    end
  end

  root to: 'tasks#index'
end
