class WelcomeController < ApplicationController

  def index
    @dogs = Dog.all
    if current_user
      @dogs = Dog.where.not(user_id: current_user.id)
    end
  end

end
