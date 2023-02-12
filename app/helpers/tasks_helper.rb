module TasksHelper

  def parse_task(task)
    priority_pattern = /^(\([A-Z]\)[ ])/
    context_pattern = /(?<=^|[ ])(@[^[ ]]+)/
    project_pattern = /(?<=^|[ ])(\+[^[ ]]+)/

    task
      .gsub(priority_pattern, '')
      .gsub(context_pattern, '<span class="context"><a href="/tasks?q=\1" target="_top">\1</a></span>')
      .gsub(project_pattern, '<span class="project"><a href="/tasks?q=\1" target="_top">\1</a></span>')
  end

  def priority(task)
    priority_pattern = /^(\([A-Z]\)[ ])/
    task.match(priority_pattern)
  end
end
