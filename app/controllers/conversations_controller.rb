class ConversationsController < ApplicationController

  def create
    @conversation = Conversation.create!(conversation_params)
    if @conversation.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
