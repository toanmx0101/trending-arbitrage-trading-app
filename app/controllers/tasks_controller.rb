class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = TaskQueryCommand.call(task_query_params).result
  end

  def show
  end

  def new
    @task = current_user.tasks.build
  end

  def edit
  end

  def create
    @task = current_user.tasks.build(task_params)
    @task.deadline = Time.parse(task_params[:deadline])

    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if update_task
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed.", :cache_control => "no-cache, no-store" }
      format.json { head :no_content }
    end
  end

  private
    def set_task
      @task = Task.find_by!(user: current_user, id: params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :description, :deadline, :sort_by, :sort_order, :due_today, :is_completed)
    end

    def update_task
      @task.update(task_params)
    end

    def task_query_params
      {
        current_user: current_user,
        keyword_search: params[:keyword_search],
        page: params[:page],
        limit: params[:limit],
        sort_by: params[:sort_by],
        sort_order: params[:sort_order],
        due_today: params[:due_today],
      }
    end
end
