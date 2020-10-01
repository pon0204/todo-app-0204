class BoardsController < ApplicationController

  # before_action :set_board, only: [:show] #showのアクション前で実施

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy] #ログインしていないと使用できない様になる
  
  def show
    # @comments = @article.comments
  end

  def index
  
  end

  def new  #フォームを表示 ログインユーザーをviewに渡す
    @board = current_user.boards.build #ログインしているユーザーを取得し、空の箱を作っている
  end

  def create #newのフォームの内容を取得し。作成する
    @board = current_user.boards.build(board_params) #フォームの入力内容を@articleに代入
    if @board.save #取得できた場合は保存
      redirect_to boards_path ,notice: '保存できたよ' #ホームページに戻る(@board)をつけるとタスクidのページにいく
      else
        flash.now[:error] = '保存に失敗しました' #エラーメッセージの表示
        render :new #フォームに戻る
    end
  end

private
def board_params  #フォームの入力内容が回ってくる
    params.require(:board).permit(:name, :description) #boardの配列からnameとdescriptionの内容を取得しリターン
end

# def set_board   #以下を各実行前に処理
#   @board = Board.find(params[:id]) #paramsidでボードののId 記事のボードを取得@boardsに代入 @はビューに渡すため
# end
end