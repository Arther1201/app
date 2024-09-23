class ChatRoomsController < ApplicationController
  def index
    @chat_rooms = ChatRoom.joins(:department).where.not(departments: { id: current_user.department_id })
  end

  def show
    @chat_room = ChatRoom.find(params[:id])
    @messages = @chat_room.messages.order(created_at: :asc)
    @message = Message.new
  end
end
