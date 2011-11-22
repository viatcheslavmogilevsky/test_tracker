class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  

  has_many :accounts
  has_many :tasks
  has_many :comments
  has_many :projects
  has_many :members, :dependent => :destroy

  validates :name, :presence => true
  


  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name
  
  def user_accounts
    self.accounts.map {|account| [account.name, account.id]}
  end

  def available_accounts
    self.members.map {|member| member.account}
  end
end

