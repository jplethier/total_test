class Api::TasksController < Api::ApplicationController
  respond_to :json

  before_filter :get_task_and_check_ownership, only: [:destroy, :update, :done, :undone]

  def index
    @tasks = current_resource_owner.tasks
    @tasks = @tasks.order_by(params[:order]) if params[:order]
    render json: @tasks.to_json
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_resource_owner

    if @task.save
      render json: @task.to_json, status: :created
    else
      render json: @task.to_json, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    render json: @task.to_json, status: :ok
  end

  def update
    if @task.update_attributes(task_params)
      render json: @task.to_json, status: :ok
    else
      render json: @task.to_json, status: :unprocessable_entity
    end
  end

  def done
    @task.done!
    render json: @task.to_json, status: :ok
  end

  def undone
    @task.undone!
    render json: @task.to_json, status: :ok
  end

  private

  def task_params
    params[:task] = eval(params[:task])
    params.require(:task).permit(:name, :due_date, :priority)
  end

  def get_task_and_check_ownership
    @task = current_resource_owner.tasks.where(id: params[:id]).first

    if @task.blank?
      render json: {}, status: :forbidden
      return false
    end
  end
end