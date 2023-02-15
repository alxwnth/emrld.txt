class TasksController < ApplicationController
  def index
    @tasks = Task.all
    @task = Task.new
  end

  def import
    render "import"
  end

  def batch_add
    # TODO Refactor addition logic to avoid duplicating the code
    task_array = import_params[:tasklist].split(/\r?\n/)
    creation_date_pattern = /(?<=^|\([A-Z]\)[ ])((\d{4})-(\d{2})-(\d{2}))(?=[ ]|$)/

    task_array.each do |task_body|

      task_body.lstrip!

      creation_date = task_body.match(creation_date_pattern)
      task_body.gsub!(creation_date_pattern, "")

      task = Task.new(description: task_body)

      if import_params[:add_dates].eql?("1")
        task.creation_time = Time.now.to_datetime
      end

      unless creation_date.nil?
        task.creation_time = DateTime.strptime(creation_date[0] << "T00:00:00", "%Y-%m-%dT%H:%M:%S")
      end

      unless task.save
        format.html { redirect_to tasks_url, status: :unprocessable_entity }
      end
    end
    redirect_to tasks_url

  end

  def create

    creation_date_pattern = /(?<=^|\([A-Z]\)[ ])((\d{4})-(\d{2})-(\d{2}))(?=[ ]|$)/
    creation_date = task_params[:description].match(creation_date_pattern)

    @task = Task.new(task_params)
    if creation_date.nil?
      @task.creation_time = Time.now.to_datetime
    else
      task_params[:description].gsub!(creation_date_pattern, "")
      @task.creation_time = DateTime.strptime(creation_date[0] << "T00:00:00", "%Y-%m-%dT%H:%M:%S")
    end

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

  # There *HAS* to be a better way, right?
  def export
    priority_pattern = /^(\([A-Z]\)[ ])/
    all_tasks = ""

    Task.where(completed: false).each do |task|
      task_text = task[:description]
      priority = task_text.match(priority_pattern)
      task_text.gsub!(priority_pattern, "")

      unless priority.nil?
        all_tasks << priority[0]
      end
      unless task[:creation_time].nil?
        all_tasks << task[:creation_time].to_datetime.strftime("%Y-%m-%d") << " "
      end
      all_tasks << task_text << "\r\n"
    end
    send_data all_tasks, :filename => "todo.txt"
  end

  def purge_completed
    Task.where(completed: true).each do |task|
      task.destroy
    end
    redirect_to tasklog_path
  end

  private

  def task_params
    params.require(:task).permit(:description)
  end

  def import_params
    params.require(:task).permit(:tasklist, :add_dates)
  end

end