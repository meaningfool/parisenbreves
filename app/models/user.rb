class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  attr_accessible :email, :name, :password, :password_confirmation, :role, as: :admin
  has_many :comments, dependent: :destroy
  has_secure_password

  before_save { |user| user.email = user.email.downcase }
  before_save :create_remember_token

  VALID_NAME_REGEX = /^\w+$/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  ROLES = %w[guest standard editor admin]

  validates :name, presence: true
  validates :name, :format => { with: VALID_NAME_REGEX }
  validates :name, :length => { maximum: 50 }
  validates :name, uniqueness: { case_sensitive: false }

  validates :email, presence: true
  validates :email, :format => { with: VALID_EMAIL_REGEX }
  validates :email, uniqueness: { case_sensitive: false }

  validates :password, :length => { minimum: 6}, on: :create
  validates_confirmation_of :password, on: :create
  validates :password_confirmation, presence: true, on: :create

  validates :password, :length => { minimum: 6}, on: :update, :unless => lambda{ |user| user.password.blank? } 
  validates_confirmation_of :password, on: :update, :unless => lambda{ |user| user.password.blank? } 
  validates :password_confirmation, presence: true, on: :update, :unless => lambda{ |user| user.password.blank? } 

  #validates :role, presence: true
  validates :role, :inclusion => { :in => ROLES }

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end
