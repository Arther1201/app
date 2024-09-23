class MessagesController < ApplicationController
  def create
    @chat_room = ChatRoom.find(params[:chat_room_id])
    @message =@chat_room.messages.build(message_params)
    @message.user = current_user

    if @message.save
      redirect_to chat_room_path(@chat_room)
    else
      render 'chat_rooms/index'
    end
  end

  def favorite
    @message = Message.find(params[:id])
    @chat_room = @message.chat_room
    
    # お気に入りをトグル（ON/OFF）するロジック
    if current_user.favorited_messages.exists?(@message.id)
      current_user.favorited_messages.delete(@message)
      @status = 'unfavorited'
    else
      current_user.favorited_messages << @message
      @status = 'favorited'
    end

    @favorite_messages = current_user.favorited_messages.order(created_at: :asc)
    
    respond_to do |format|
      format.json { render json: { status: @status } }
    end
  end

  

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
