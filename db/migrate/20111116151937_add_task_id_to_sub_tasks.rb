class AddTaskIdToSubTasks < ActiveRecord::Migration
  def self.up
    add_column :sub_tasks, :task_id, :integer
  end

  def self.down
    remove_column :sub_tasks, :task_id
  end
end
