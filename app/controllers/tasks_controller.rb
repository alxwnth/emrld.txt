class TasksController < ApplicationController
  def index
    @tasks = Task.all
    @task = Task.new
  end

  def create

    @task = Task.new(task_params)
    @task.creation_time = Time.now.to_datetime

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_url }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def toggle
    @task = Task.find(params[:id])

    if @task.completed
      completion_time = nil
    else
      completion_time = Time.now.to_datetime
    end

    @task.update(completed: params[:completed], completion_time: completion_time)

    render json: { message: "Success" }
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_url }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to request.referrer
  end

  def tasklog
    @tasks = Task.where(completed: true)
    render "tasklog"
  end

  private

  def task_params
    params.require(:task).permit(:description)
  end

end