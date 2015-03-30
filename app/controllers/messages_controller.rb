require 'pry'
class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
    :authenticate_user
  end

  @clients = []
  EM.run do
    EM::WebSocket.start(host: ENV['WEBSOCKET_HOST'], port: ENV['WEBSOCKET_PORT']) do |ws|
      crypt = ActiveSupport::MessageEncryptor.new(ENV['SECRET_KEY_BASE'])
      p crypt
      ws.onopen do |handshake|
        conversation_data = crypt.decrypt_and_verify(handshake.query_string)
        @clients << {socket: ws, conv_info: conversation_data}
        ws.send Conversation.find(conversation_data[:conversation_id]).messages.last(10).to_json
      end

      ws.onclose do
        ws.send "Closed."
        @clients.delete ws
      end

      ws.onmessage do |data|
        data = data.split('L56HTY9999')
        body = data[0]
        key = data[-1]
        conversation = crypt.decrypt_and_verify(key)
        new_message = Message.new(body: body, user_id: conversation[:user_id], conversation_id: conversation[:conversation_id])
        if new_message.save
          @clients.each do |socket|
            if socket[:conv_info][:conversation_id] == conversation[:conversation_id]
              socket[:socket].send new_message.to_json
            end
          end
        else
          if socket[:conv_info][:user_id] == conversation[:user_id]
            socket[:socket].send new_message.errors.to_json
          end
        end
      end
    end
  end

  def index
    # finding conversations that do not have blocked user ids in them
    crypt = ActiveSupport::MessageEncryptor.new(ENV['SECRET_KEY_BASE'])
    @conv_id = crypt.encrypt_and_sign({:user_id=>current_user.id,:conversation_id=>@conversation.id})
    users_inbox_list = Conversation.where("(conversations.sender_id = ? ) OR (conversations.recipient_id =?)", current_user.id, current_user.id)
    current_user.blocked_users_info.each do |blocked_hash|
      users_inbox_list = users_inbox_list.where.not("(conversations.sender_id = ? ) OR (conversations.recipient_id =?)", blocked_hash[:user].id, blocked_hash[:user].id)
    end
    @current_messages = []
    users_inbox_list.each do |conversation|
      if conversation.messages.length > 0
        @current_messages.push(conversation.messages.last)
      end
    end
    @current_messages = @current_messages.sort{ |a,b| b.created_at <=> a.created_at }
    @messages= @conversation.messages
    @messages = @conversation.messages
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end
    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end
    if @messages.last
      if @messages.last.user_id != current_user.id
        @messages.last.read = true
        @messages.last.save
      end
    end
  end

  def create(body)
    @message = @conversation.messages.new(message_params)
    @message.user_id = current_user.id
    @message = @conversation.messages.new(body: body, user_id: current_user.id)
    if @message.save
      render json: @message
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private
  def message_params
    params.require(:message).permit(:body)
  end
end
