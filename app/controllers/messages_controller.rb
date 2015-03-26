class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
    :authenticate_user
  end
  def index
    @message = @conversation.messages.new
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
        @messages.last.read = true;
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
