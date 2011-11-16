class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :sub_tasks
end
