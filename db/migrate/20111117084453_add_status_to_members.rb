class AddStatusToMembers < ActiveRecord::Migration
  def self.up
    add_column :members, :status, :boolean
    remove_column :members, :created_at
    remove_column :members, :updated_at
  end

  def self.down
    remove_column :members, :status
  end
end
