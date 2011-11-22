class Account < ActiveRecord::Base
  has_many :members, :dependent => :destroy
  has_many :projects
  belongs_to :user

  validates :name, :presence => true

  def requests
  	 self.members.where(:status => false)
  end	

  def true_members
  	 self.members.where(:status => true)
  end
end
