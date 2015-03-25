class UsersController < ApplicationController

  def profile
    user = current_user
    @conversations = Conversation.where("(conversations.sender_id = ? ) OR (conversations.recipient_id =?)", user.id, user.id)
    @dogs = Dog.where.not(user_id: current_user.id)
    @users_dogs = current_user.dogs
    @filters = user.filters
  end
end
