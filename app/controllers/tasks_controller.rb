class TasksController < ApplicationController
  load_and_authorize_resource

  prepend_before_filter do
    params[:task] &&= task_params
  end

  def index
    @new_task = current_user.tasks.build
  end

  def create
    @task.user = current_user
    if @task.save
      flash.now[:notice] = 'Task created'
      render :task_created
    else
      flash.now[:error] = 'Could not create the task'
      render :task_error
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :due_date, :priority)
  end
end
