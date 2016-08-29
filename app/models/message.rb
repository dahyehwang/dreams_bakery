class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent, class_name: "Message"
  
  has_many :likes
  has_many :users_liked, through: :likes, source: :user
  has_many :comments, class_name: "Message", foreign_key: "parent_id", dependent: :destroy

  validates :message, presence: true, length: { in: 2..255 }
  # validates :parent, :word_count_is_less_than_4

  private

	def word_count_is_less_than_4
    errors[:message] << "too many words" if desc.split.size > 3
  end
end
