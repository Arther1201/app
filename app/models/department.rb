class Department < ApplicationRecord
    has_many :users
    has_one :chat_room
    has_many :supplies
end
