class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room
  has_and_belongs_to_many :favorited_by, class_name: 'User', join_table: 'favorites'
end
