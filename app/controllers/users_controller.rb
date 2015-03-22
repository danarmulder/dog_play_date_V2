class UsersController < ApplicationController

  def profile
    @conversations = current_user.conversations 
  end
end
