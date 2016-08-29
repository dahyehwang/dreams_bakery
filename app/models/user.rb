class User < ActiveRecord::Base
  has_secure_password
  
  has_many :messages, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :messages_liked, through: :likes, source: :message, dependent: :destroy

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, presence: true, length: { minimum: 2 }
  validates :nickname, presence: true, allow_blank: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :password, confirmation: true, length: {minimum: 8}
end
