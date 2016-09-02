class User < ActiveRecord::Base
  before_save do
    self.email.downcase!
  end
  has_attached_file :avatar, :default_url => "/assets/eyeball2.png"
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  has_many :messages, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :messages_liked, through: :likes, source: :message, dependent: :destroy

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  
  validates :first_name, :last_name, :email, presence: true
  validates :first_name, :last_name, length: { minimum: 2 }
  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :nickname, uniqueness: { case_sensitive: false}, allow_blank: true 
  validates :password, length: {minimum: 8}, on: [:create]
  has_secure_password
  # validates :password, :password_confirmation, presence: true, on: [:create]

end
