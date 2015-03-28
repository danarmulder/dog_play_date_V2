require 'pry'
class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
    :authenticate_user
  end
  def index
    users_inbox_list = Conversation.where("(conversations.sender_id = ? ) OR (conversations.recipient_id =?)", current_user.id, current_user.id)
    @current_messages = []
    users_inbox_list.each do |conversation|
      @current_messages.push(conversation.messages.last)
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

  def create
    @message = @conversation.messages.new(message_params)
    @message.user_id = current_user.id
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
