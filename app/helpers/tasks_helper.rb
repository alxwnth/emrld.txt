module TasksHelper

  def parse_task(task_description)
    # TODO: Move patterns out of here to avoid duplication
    priority_pattern = /^(\([A-Z]\)[ ])/
    context_pattern = /(?<=^|[ ])(@[^[ ]]+)/
    project_pattern = /(?<=^|[ ])(\+[^[ ]]+)/
    markdown_link_pattern =  /^\[([\w\s\d]+)\]\(((?:\/|https?:\/\/)[\w\d.\/?=#]+)\)$/

    task_description
      .gsub(priority_pattern, '')
      .gsub(context_pattern, '<span class="context"><a href="/tasks?q=\1" target="_top">\1</a></span>')
      .gsub(project_pattern, '<span class="project"><a href="/tasks?q=\1" target="_top">\1</a></span>')
  end

  def priority(task_description)
    priority_pattern = /^(\([A-Z]\)[ ])/
    task_description.match(priority_pattern)
  end

  def contexts(tasks)
    context_pattern = /(?<=^|[ ])(@[^[ ]]+)/
    parse_tags(tasks, context_pattern)
  end

  def projects(tasks)
    project_pattern = /(?<=^|[ ])(\+[^[ ]]+)/
    parse_tags(tasks, project_pattern)
  end

  def uncompleted(tasks)
    tasks.where(completed: false)
  end

  def completed(tasks)
    tasks.where(completed: true)
  end

  def parse_tags(tasks, pattern)

    contexts = []
    tasks.each do |task|
      contexts << task.description.to_enum(:scan, pattern).map { $& }
    end
    contexts.flatten.uniq
  end

end
