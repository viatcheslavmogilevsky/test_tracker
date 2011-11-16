class CreateSubTasks < ActiveRecord::Migration
  def self.up
    create_table :sub_tasks do |t|
      t.string :title
      t.boolean  :checked

      t.timestamps
    end
  end

  def self.down
    drop_table :sub_tasks
  end
end
