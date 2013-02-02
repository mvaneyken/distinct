class Technician < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :registerable,
  # :lockable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :timeoutable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name, :last_name
  
  validates :email, :presence => true, :uniqueness => true
  validates :email, :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :message => 'Invalid email format'}, :if => "email.present?"
  validates :first_name, :presence => true, :uniqueness => {:scope => :last_name}
  validates :last_name, :presence => true, :uniqueness => {:scope => :first_name}
  
  def timeout_in
    60.minutes
  end
  
end
