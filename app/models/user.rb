class User < ActiveRecord::Base
  before_save do
    self.email.downcase!
  end
  
  has_many :messages, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :messages_liked, through: :likes, source: :message, dependent: :destroy

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  
  validates :first_name, :last_name, :email, presence: true
  validates :first_name, :last_name, length: { minimum: 2 }
  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :nickname, uniqueness: { case_sensitive: false}, allow_blank: true 
  validates :password, length: {minimum: 8}
  has_secure_password
  # validates :password, :password_confirmation, presence: true, on: [:create]

end
