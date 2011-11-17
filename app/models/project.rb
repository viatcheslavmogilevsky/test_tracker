class Project < ActiveRecord::Base
  belongs_to :account
  belongs_to :user
  has_many :tasks, :dependent => :destroy

  validates :title, :presence => true

  def current_tasks
    self.tasks.where(:status => "Current")
  end

  def started_tasks
    self.tasks.where(:status => "Started")
  end

  def finished_tasks
    self.tasks.where(:status => "Finished")
  end
  
end
