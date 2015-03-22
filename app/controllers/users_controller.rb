class UsersController < ApplicationController

  def profile
    user = current_user
    @conversations = Conversation.where("(conversations.sender_id = ? ) OR (conversations.recipient_id =?)", user.id, user.id)
  end
end
