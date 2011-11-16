class Account < ActiveRecord::Base
  has_many :members
  has_many :projects
  belongs_to :user
end
