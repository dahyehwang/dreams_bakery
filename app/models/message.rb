class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent, class_name: "Message"
  
  has_many :likes
  has_many :users_liked, through: :likes, source: :user  ## people who liked this message
  has_many :comments, class_name: "Message", foreign_key: "parent_id", dependent: :destroy

  validates :content, presence: true
  validates :content, :length => { :maximum => 7, :tokenizer => lambda { |str| str.scan(/\w+/) }, :too_long  => "Please limit your summary to %{count} words" }, unless: :comment?
  validates :content, length: { in: 2..255 }, unless: :post?

  private

  def comment?
    parent_id != nil
  end

  def post?
    parent_id == nil
  end

end
