class ChatRoom < ApplicationRecord
  belongs_to :department
  has_many :messages
end
