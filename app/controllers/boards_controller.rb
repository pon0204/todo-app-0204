class BoardsController < ApplicationController

  before_action :set_board, only: [:show] #showのアクション前で実施

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy] #ログインしていないと使用できない様になる
  
  def index
   @boards = Board.all #タスクを配列にして挿入
  end

  def show
    @tasks = @board.tasks
    @task = Task.find(params[:id])
  end

  def new  #フォームを表示 ログインユーザーをviewに渡す
    @board = current_user.boards.build #ログインしているユーザーを取得し、空の箱を作っている
  end

  def create #newのフォームの内容を取得し。作成する
    @board = current_user.boards.build(board_params) #フォームの入力内容を@articleに代入
    if @board.save #取得できた場合は保存
      redirect_to boards_path, notice: '保存できたよ' #ホームページに戻る(@board)をつけるとタスクidのページにいく
    else
        flash.now[:error] = '保存に失敗しました' #エラーメッセージの表示
        render :new #フォームに戻る
    end
  end

  def edit
    @board = current_user.boards.find(params[:id]) #ページのidを取得し、インスタンスに変換
  end

  def update
    @board = current_user.boards.find(params[:id]) #他人に編集されない様に、current_userを付ける
   if @board.update(board_params)      #update【値更新】のメソッドがある。フォームの値を指定(params)
    redirect_to board_path(@board), notice: '更新できました'     #パスを指定して記事のページに飛ぶ
   else
    flash.now[:error] = '更新できませんでした' #メッセージの表示
    render :edit #編集画面に移動
   end
end

def destroy
board = current_user.boards.find(params[:id]) #記事のid取得 @を付けると、viewで表示出来る
board.destroy! #記事の削除 !はデストロイ失敗した時にエラーがでて処理が止まる。
redirect_to root_path, notice: '削除に成功しました' #削除後、記事一覧に飛ぶ
end

private
def board_params  #フォームの入力内容が回ってくる
    params.require(:board).permit(:name, :description) #boardの配列からnameとdescriptionの内容を取得しリターン
end

# .require(:board)

def set_board   #以下を各実行前に処理
  @board = Board.find(params[:id]) #paramsidでボードののId 記事のボードを取得@boardsに代入 @はビューに渡すため
end
end