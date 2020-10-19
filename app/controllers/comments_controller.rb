class CommentsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy] #ログインしていないと使用できない様になる

def new
@task = Task.find(params[:task_id])
@comment = @task.comments.build
end

def create
@task = Task.find(params[:task_id])
@comment = @task.comments.build(comments_params)
if @comment.save! 
  redirect_to board_task_path(board_id: @task.board_id, id: @task.id), notice: 'タスクを追加'
else
  flash.now[:error] = '更新できませんでした'
  render :new
end
end

private
def comments_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id )
end

end