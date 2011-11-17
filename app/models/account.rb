class Account < ActiveRecord::Base
  has_many :members, :dependent => :destroy
  has_many :projects
  belongs_to :user

  validates :name, :presence => true
end
