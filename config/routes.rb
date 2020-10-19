Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'boards#index' #タスク一覧の表示

  resources :boards do  #crud機能の作成
  
    resources :tasks   #crud機能の作成

  end
  
  resources :tasks do
    resources :comments, only: [:new, :create]
  end


  resource :profile, only: [:show, :edit, :update]


end


# ユーザ認証（ログイン、ログアウト）
# ログインするとボードを作成できる
# タスクには、タイトル・内容・期限がある
# タスクはユーザに紐づく
# # タスクを作成したユーザのみがタスクを追加したり削除できる