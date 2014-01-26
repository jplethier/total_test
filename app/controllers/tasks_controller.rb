class TasksController < ApplicationController
  load_and_authorize_resource

  prepend_before_filter do
    params[:task] &&= task_params
  end

  def index
    if request.xhr?
      @tasks = @tasks.order_by(params[:order_by])
    else
      @new_task = current_user.tasks.build
    end
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

  def destroy
    @task_id = params[:id]
    @task.destroy
    flash.now[:notice] = 'Task deleted'
  end

  def update
    if @task.update_attributes(task_params)
      flash.now[:notice] = 'Task updated'
      render :task_updated
    else
      flash.now[:error] = 'Could not update the task'
      render :task_error
    end
  end

  def done
    @task.done!
    flash.now[:notice] = 'Task completed'
  end

  def undone
    @task.undone!
    flash.now[:notice] = 'Task opened'
  end

  private

  def task_params
    params.require(:task).permit(:name, :due_date, :priority)
  end
end
