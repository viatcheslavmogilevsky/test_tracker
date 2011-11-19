class Member < ActiveRecord::Base
  belongs_to :account
  belongs_to :user

  validates :user_id, :uniqueness => {:scope => :account_id}
end
