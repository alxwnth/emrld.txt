class AddCreatedAndCompletedToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :creation_time, :datetime
    add_column :tasks, :completion_time, :datetime
  end
end
