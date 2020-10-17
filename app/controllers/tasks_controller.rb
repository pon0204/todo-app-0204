class TasksController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy] #ログインしていないと使用できない様になる

  def index
    @tasks = Task.all #タスクを配列にして挿入
   end

def new
  board = Board.find(params[:board_id]) #boardにBoardのidをfindし、 
  @task = board.tasks.build   # board/board_id/taskをビルド
end

# /boards/:board_id/tasks/new(.:format)


def show
  # board = Board.find(params[:board_id])
  # @tasks = board.tasks(params[:id])
  @tasks = Task.find(params[:id])
end

# /boards/:board_id/tasks/:id(.:format)

def create
  board = Board.find(params[:board_id])
  @task = board.tasks.build(task_params) 
  if @task.save!
    redirect_to board_path(board), notice: 'タスクを追加'
  else
    flash.now[:error] = '更新できませんでした'
    render :new
  end
end


# /boards/:board_id/tasks(.:format)

private
def task_params
    params.require(:task).permit(:title, :content, :eyecatch, :deadline).merge(user_id: current_user.id)
end

end

